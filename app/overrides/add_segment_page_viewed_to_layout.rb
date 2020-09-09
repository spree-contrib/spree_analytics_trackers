spree_version = Gem.loaded_specs['spree_core'].version
unless spree_version >= Gem::Version.create('3.3.0') && spree_version < Gem::Version.create('3.5.0') && spree_version != Gem::Version.create('3.5.0.alpha')
  Deface::Override.new(
    virtual_path: 'spree/shared/_head',
    name: 'add_segment_page_tracker_to_body',
    insert_before: 'meta',
    partial: 'spree/shared/trackers/segment/page_viewed.js',
    original: '6841b819babbe4df1f03d0bc8e05dc81bf0d45ad'
  )
end
