# coding: utf-8
require 'spec_helper'

describe 'Visiting Products', type: :feature, js: true do
  include_context 'custom products'

  let(:store) { Spree::Store.default }

  let(:store_name) do
    ((first_store = Spree::Store.first) && first_store.name).to_s
  end

  let!(:ga_tracker) { create(:tracker) }
  let!(:segment_tracker) { create(:tracker, engine: :segment) }

  before do
    visit spree.products_path
    allow(ENV).to receive(:[]).and_call_original
  end

  it 'is able to show the shopping cart after adding a product to it' do
    click_link 'Ruby on Rails Ringer T-Shirt'
    expect(page).to have_content('$159.99')

    expect(page).to have_selector('form#add-to-cart-form')
    expect(page).to have_selector(:button, id: 'add-to-cart-button', disabled: false)
    click_button 'add-to-cart-button'
    expect(page).to have_content(Spree.t(:added_to_cart))
  end

  context 'using Russian Rubles as a currency' do
    before do
      store.update(default_currency: 'RUB')
    end

    let!(:product) do
      product = Spree::Product.find_by(name: 'Ruby on Rails Ringer T-Shirt')
      product.master.prices.create(amount: 19.99, currency: 'RUB')
      product.tap(&:save)
    end

    # Regression tests for #2737
    context 'uses руб as the currency symbol' do
      it 'on products page' do
        visit spree.products_path
        within("#product_#{product.id}") do
          within('.product-component-price') do
            expect(page).to have_content('19.99 ₽')
          end
        end
      end

      it 'on product page' do
        visit spree.product_path(product)
        within('.price') do
          expect(page).to have_content('19.99 ₽')
        end
      end

      it 'when adding a product to the cart' do
        add_to_cart(product)

        within('.shopping-cart-total-amount') do
          expect(page).to have_content('19.99 ₽')
        end
      end
    end
  end

  it 'is able to search for a product' do
    find('.search-icons').click
    fill_in 'keywords', with: 'shirt'

    if Spree.version.to_f > 4.1
      first('button[type=submit]').click
    else
      find('#search-dropdown label').click
    end

    expect(page).to have_css('.product-component-name').once
  end

  context 'a product with variants' do
    let(:product) { Spree::Product.find_by(name: 'Ruby on Rails Baseball Jersey') }
    let(:option_value) { create(:option_value) }
    let!(:variant) { build(:variant, price: 5.59, product: product, option_values: []) }

    before do
      image = File.open(File.expand_path('../fixtures/thinking-cat.jpg', __dir__))
      create_image(product, image)

      product.option_types << option_value.option_type
      variant.option_values << option_value
      variant.save!
    end

    it 'is displayed' do
      expect { click_link product.name }.not_to raise_error
    end

    it 'displays price of first variant listed' do
      click_link product.name
      within('#product-price') do
        expect(page).to have_content variant.price
        expect(page).not_to have_content Spree.t(:out_of_stock)
      end
    end

    it "doesn't display out of stock for master product" do
      product.master.stock_items.update_all count_on_hand: 0, backorderable: false

      click_link product.name
      within('#product-price') do
        expect(page).not_to have_content Spree.t(:out_of_stock)
      end
    end

    it "doesn't display cart form if all variants (including master) are out of stock" do
      product.variants_including_master.each { |v| v.stock_items.update_all count_on_hand: 0, backorderable: false }

      click_link product.name
      within('[data-hook=product_price]') do
        expect(page).not_to have_content Spree.t(:add_to_cart)
      end
    end
  end

  context 'a product with variants, images only for the variants' do
    let(:product) { Spree::Product.find_by(name: 'Ruby on Rails Baseball Jersey') }
    let(:variant1) { create(:variant, product: product, price: 9.99) }
    let(:variant2) { create(:variant, product: product, price: 10.99) }

    before do
      image = File.open(File.expand_path('../fixtures/thinking-cat.jpg', __dir__))
      create_image(variant1, image)
    end

    it 'does not display no image available' do
      visit spree.products_path
      expect(page).to have_selector("img[data-src$='thinking-cat.jpg']")
    end
  end

  context 'an out of stock product without variants' do
    let(:product) { Spree::Product.find_by(name: 'Ruby on Rails Tote') }

    before do
      product.master.stock_items.update_all count_on_hand: 0, backorderable: false
    end

    it 'does display out of stock for master product' do
      click_link product.name
      within('#inside-product-cart-form') do
        expect(page).to have_content Spree.t(:out_of_stock).upcase
      end
    end

    it "doesn't display cart form if master is out of stock" do
      click_link product.name
      within('[data-hook=product_price]') do
        expect(page).not_to have_content Spree.t(:add_to_cart)
      end
    end
  end

  context 'pagination' do
    before { Spree::Config.products_per_page = 3 }

    it 'is able to display products priced between 151 and 200 dollars across multiple pages' do
      find(:css, '#filtersPrice').click
      within(:css, '#collapseFilterPrice') { click_on '$151 - $200' }
      expect(page).to have_css('.product-component-name').exactly(3).times
      next_page = find_all(:css, '.next_page')
      within(next_page[0]) { find(:css, '.page-link').click }
      expect(page).to have_css('.product-component-name').once
    end
  end

  it 'returns the correct title when displaying a single product' do
    product = Spree::Product.find_by(name: 'Ruby on Rails Baseball Jersey')
    click_link product.name

    within('div#product-description') do
      within('h1.product-details-title') do
        expect(page).to have_content('Ruby on Rails Baseball Jersey')
      end
    end
  end

  context 'product is on sale' do
    let(:product) do
      FactoryBot.create(:base_product, description: 'Testing sample', name: 'Sample', price: '19.99')
    end
    let(:option_type) { create(:option_type) }
    let(:option_value1) { create(:option_value, name: 'small', presentation: 'S', option_type: option_type) }
    let(:option_value2) { create(:option_value, name: 'medium', presentation: 'M', option_type: option_type) }
    let(:option_value3) { create(:option_value, name: 'large', presentation: 'L', option_type: option_type) }
    let(:variant1) { create(:variant, product: product, option_values: [option_value1], price: '49.99') }
    let(:variant2) { create(:variant, product: product, option_values: [option_value2], price: '69.99') }
    let(:variant3) { create(:variant, product: product, option_values: [option_value3], price: '89.99') }

    before do
      if Spree.version.to_f > 4.1
        price1 = Spree::Price.find_by(variant: variant1)
        price2 = Spree::Price.find_by(variant: variant2)
        price3 = Spree::Price.find_by(variant: variant3)
        price1.update(compare_at_amount: '149.99')
        price2.update(compare_at_amount: '169.99')
        price3.update(compare_at_amount: '79.99')
        price1.save
        price2.save
        price3.save

        product.master.prices.first.update(compare_at_amount: 29.99)
      end

      product.master.stock_items.update_all count_on_hand: 10, backorderable: true
      product.option_types << option_type
      product.variants << [variant1, variant2, variant3]
      product.tap(&:save)

      visit spree.product_path(product)
    end

    it 'shows pre sales price on PDP' do
      expect(page).to have_content('$49.99')
    end

    it 'shows both pre sales and current prices on PDP' do
      if Spree.version.to_f > 4.1
        expect(page).to have_content('$49.99')
        expect(page).to have_content('$149.99')
      end
    end

    it 'shows prices for other variants' do
      within('.product-variants-variant-values') do
        find('li', text: 'M').click
      end

      expect(page).to have_content('$69.99')

      if Spree.version.to_f > 4.1
        expect(page).to have_content('$169.99')
      end
    end

    it 'does not show pre sales price when it is bigger than price' do
      if Spree.version.to_f > 4.1
        within('.product-variants-variant-values') do
          find('li', text: 'L').click
        end

        expect(page).to have_content('$89.99')
        expect(page).not_to have_content('$79.99')
      end
    end
  end

  xdescribe 'When Requesting A Product By Variant Using URL Query String' do
    let(:product) do
      FactoryBot.create(:base_product, description: 'Testing sample', name: 'Sample', price: '19.99')
    end

    let(:option_type) { create(:option_type) }
    let(:option_value1) { create(:option_value, name: 'small', presentation: 'S', option_type: option_type) }
    let(:option_value2) { create(:option_value, name: 'medium', presentation: 'M', option_type: option_type) }
    let(:option_value3) { create(:option_value, name: 'large', presentation: 'L', option_type: option_type) }
    let(:variant1) { create(:variant, product: product, option_values: [option_value1], price: '49.99', sku: 'VAR-1') }
    let(:variant2) { create(:variant, product: product, option_values: [option_value2], price: '69.99', sku: 'VAR-2') }
    let(:variant3) { create(:variant, product: product, option_values: [option_value3], price: '89.99', sku: 'VAR-3') }

    before do
      product.option_types << option_type
      product.variants << [variant1, variant2, variant3]
      product.tap(&:save)
      product.stock_items.last.update count_on_hand: 0, backorderable: false
    end

    context 'Make sure the requested variant' do
      it 'shows the correct price in the HTML' do
        visit spree.product_path(product) + '?variant=' + variant3.id.to_s
        expect(page).to have_content(variant3.price.to_s)
      end

      it 'shows back-ordered in the HTML when product is on backorder' do
        visit spree.product_path(product) + '?variant=' + variant2.id.to_s
        expect(page).to have_content('BACKORDERED')
      end

      it 'shows out of stock in the HTML when the product is unavailable' do
        visit spree.product_path(product) + '?variant=' + variant3.id.to_s
        expect(page).to have_content('OUT OF STOCK')
      end

      it 'does not update the variant HTML details if no variant is matched' do
        visit spree.product_path(product) + '?variant=9283923297832973283'
        expect(page).to have_content(variant1.price.to_s)
        expect(page).to have_content('BACKORDERED')
      end

      it 'sets JSON in the Schema.org SKU, URL, price and availability' do
        visit spree.product_path(product) + '?variant=' + variant3.id.to_s

        jsonld = page.find('script[type="application/ld+json"]', visible: false).text(:all)
        jsonstring = Capybara.string(jsonld)

        expect(jsonstring).to have_text('?variant=' + variant3.id.to_s)
        expect(jsonstring).to have_text('"availability":"OutOfStock"')
        expect(jsonstring).to have_text('"sku":"VAR-3"')
        expect(jsonstring).to have_text('"price":"89.99"')
      end
    end
  end
end
