if Gem.loaded_specs['spree_core'].version >= Gem::Version.create('3.5.0')
  Deface::Override.new(
    virtual_path: 'spree/orders/show',
    name: 'add_lead_purchase',
    insert_before: "#order_summary",
    partial: 'spree/shared/trackers/leads/purchase.html',
    original: 'ac7f302922a3c1bb080095296ccc20e42bab2967'
  )
end
