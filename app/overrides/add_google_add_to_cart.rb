if Gem.loaded_specs['spree_core'].version >= Gem::Version.create('3.5.0.alpha')
  Deface::Override.new(
    virtual_path: 'spree/orders/edit',
    name: 'add_google_add_to_cart',
    insert_top: "[data-hook='cart_container']",
    partial: 'spree/shared/trackers/google_analytics/add_to_cart.js'
  )
end
