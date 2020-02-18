spree_version = Gem.loaded_specs['spree_core'].version
unless spree_version >= Gem::Version.create('3.3.0') && spree_version < Gem::Version.create('3.5.0') && spree_version != Gem::Version.create('3.5.0.alpha')
  Deface::Override.new(
    virtual_path: 'spree/layouts/spree_application',
    name: 'add_segment_initializer_to_layout',
    insert_bottom: '[data-hook="inside_head"]',
    partial: 'spree/shared/trackers/segment/initializer.js',
    original: '6841b819babbe4df1f03d0bc8e05dc81bf0d45ad'
  )

  Deface::Override.new(
    virtual_path: 'spree/layouts/spree_application',
    name: 'add_segment_page_tracker_to_body',
    insert_bottom: '[data-hook="body"]',
    partial: 'spree/shared/trackers/segment/page_viewed.js',
    original: '6841b819babbe4df1f03d0bc8e05dc81bf0d45ad'
  )
end
