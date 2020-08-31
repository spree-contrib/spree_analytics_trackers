spree_version = Gem.loaded_specs['spree_core'].version
unless spree_version >= Gem::Version.create('3.4.0') && spree_version < Gem::Version.create('3.5.0')
  Deface::Override.new(
    virtual_path: 'spree/checkout/edit',
    name: 'add_segment_checkout_step_viewed_to_checkout_edit',
    insert_after: '[data-hook="checkout_content"]',
    partial: 'spree/shared/trackers/segment/checkout_step_viewed.js',
    original: '806d2120a1ca1050fb093962fee10363c0944b0a'
  )

  Deface::Override.new(
    virtual_path: 'spree/checkout/edit',
    name: 'add_ga_checkout_step_viewed_to_checkout_edit',
    insert_after: '[data-hook="checkout_content"]',
    partial: 'spree/shared/trackers/google_analytics/checkout_step_viewed.js',
    original: '0ac5c18a2db215bf8ba30470a0e5d69e00d0313a'
  )

  Deface::Override.new(
    virtual_path: 'spree/checkout/edit',
    name: 'add_facebook_pixel_step_viewed_to_checkout_edit',
    insert_after: '[data-hook="checkout_content"]',
    partial: 'spree/shared/trackers/facebook_pixel/checkout_step_viewed.js',
    original: '0ac5c18a2db215bf8ba3s470a0e5d69e00d0313a'
  )
end
