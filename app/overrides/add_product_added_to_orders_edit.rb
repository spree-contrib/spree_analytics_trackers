spree_version = Gem.loaded_specs['spree_core'].version
unless spree_version >= Gem::Version.create('3.4.0') && spree_version < Gem::Version.create('3.5.0')
  Deface::Override.new(
    virtual_path: 'spree/orders/edit',
    name: 'add_product_added_to_orders_edit',
    insert_top: "[data-hook='cart_container']",
    partial: 'spree/shared/trackers/segment/product_added.js',
    original: '75a9171ce7647353a00bdfa178b131872e7f9bdc'
  )
end
