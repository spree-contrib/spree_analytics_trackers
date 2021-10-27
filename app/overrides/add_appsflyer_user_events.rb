spree_version = Gem.loaded_specs['spree_core'].version
unless spree_version >= Gem::Version.create('3.3.0') && spree_version < Gem::Version.create('3.5.0') && spree_version != Gem::Version.create('3.5.0.alpha')
  Deface::Override.new(
    virtual_path: 'spree/home/user_modal/_user_modal',
    name: 'add_appsflyer_user_events',
    insert_before: '#user_modal',
    partial: 'spree/shared/trackers/appsflyer/user_events.js',
    original: '6841b819babbe4df1f03d0bc8e052c81bf0d45ad'
  )
end