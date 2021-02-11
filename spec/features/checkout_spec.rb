require 'spec_helper'

describe 'Visiting Checkout page', type: :feature, js: true do
  let(:mug) { create(:product, name: 'RoR Mug') }
  let(:user) { create(:user) }

  before do
    allow_any_instance_of(Spree::OrdersController).to receive_messages(try_spree_current_user: user)
  end

  it 'is available' do
    add_to_cart(mug)
    expect { visit spree.checkout_path }.not_to raise_error
  end
end
