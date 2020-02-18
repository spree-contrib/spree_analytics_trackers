if Gem.loaded_specs['spree_core'].version >= Gem::Version.create('3.5.0.alpha')
  Deface::Override.new(
    virtual_path: 'spree/layouts/spree_application',
    name: 'add_google_analytics_to_spree_application',
    insert_top: '[data-hook="inside_head"]',
    partial: 'spree/shared/trackers/google_analytics/initializer.js',
    original: 'cfa30a2831d9a41394c03229cd28b3c7eee69585'
  )

  Deface::Override.new(
    virtual_path: 'spree/layouts/checkout',
    name: 'add_google_analytics_to_spree_checkout',
    insert_top: '[data-hook="inside_head"]',
    partial: 'spree/shared/trackers/google_analytics/initializer.js',
    original: 'ca3d46a134b93856baf937cf2e473da66d9d8efc'
  )
end
