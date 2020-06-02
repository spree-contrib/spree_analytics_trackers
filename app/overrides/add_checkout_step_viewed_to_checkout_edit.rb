spree_version = Gem.loaded_specs['spree_core'].version
unless spree_version >= Gem::Version.create('3.4.0') && spree_version < Gem::Version.create('3.5.0')
  Deface::Override.new(
    virtual_path: 'spree/checkout/edit',
    name: 'add_segment_checkout_step_viewed_to_checkout_edit',
    insert_bottom: '[data-hook="checkout_content"]',
    partial: 'spree/shared/trackers/segment/checkout_step_viewed.js',
    original: 'f7b787e3485b705d0373e248361fcb590a45478e'
  )

  Deface::Override.new(
    virtual_path: 'spree/checkout/edit',
    name: 'add_ga_checkout_step_viewed_to_checkout_edit',
    insert_bottom: '[data-hook="checkout_content"]',
    partial: 'spree/shared/trackers/google_analytics/checkout_step_viewed.js'
  )
end
