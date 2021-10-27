spree_version = Gem.loaded_specs['spree_core'].version
unless spree_version >= Gem::Version.create('3.3.0') && spree_version < Gem::Version.create('3.5.0')
  Deface::Override.new(
    virtual_path: 'spree/orders/show',
    name: 'add_appsflyer_order_complete',
    insert_before: "#order_summary",
    partial: 'spree/shared/trackers/appsflyer/order_complete.js',
    original: 'ac7f302922a3c1bb080095296ccc20e42bab2967' 
  )
end
