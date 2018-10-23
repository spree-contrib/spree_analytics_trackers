spree_version = Gem.loaded_specs['spree_core'].version
unless spree_version >= Gem::Version.create('3.4.0') && spree_version < Gem::Version.create('3.5.0')
  Deface::Override.new(
    virtual_path: 'spree/orders/edit',
    name: 'add_cart_viewed_to_orders_edit',
    insert_top: "[data-hook='cart_container']",
    partial: 'spree/shared/trackers/segment/cart_viewed.js',
    original: 'e0a3dcdf759c4ec9fad085cd8a5360c8d68167f5'
  )
end
