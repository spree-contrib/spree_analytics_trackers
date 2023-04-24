spree_version = Gem.loaded_specs['spree_core'].version
unless spree_version >= Gem::Version.create('3.4.0') && spree_version < Gem::Version.create('3.5.0')
  Deface::Override.new(
    virtual_path: 'spree/products/show',
    name: 'add_product_viewed_to_products_show',
    insert_bottom: '[data-hook="product_show"]',
    text: <<-HTML
      <%= render partial: 'spree/shared/trackers/segment/product_viewed', formats: :js %>
    HTML
  )
end
