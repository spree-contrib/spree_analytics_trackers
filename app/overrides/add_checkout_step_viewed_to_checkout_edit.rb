spree_version = Gem.loaded_specs['spree_core'].version
unless spree_version >= Gem::Version.create('3.4.0') && spree_version < Gem::Version.create('3.5.0')
  Deface::Override.new(
    virtual_path: 'spree/checkout/edit',
    name: 'add_checkout_step_viewed_to_checkout_edit',
    insert_bottom: "[data-hook='checkout_summary_box']",
    partial: 'spree/shared/trackers/segment/checkout_step_viewed.js'
  )
end
