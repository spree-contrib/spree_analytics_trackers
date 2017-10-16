if Gem.loaded_specs['spree_core'].version >= Gem::Version.create('3.5.0')
  Deface::Override.new(
    virtual_path: 'spree/layouts/admin',
    name: 'add_analytics_to_admin_sidebar',
    insert_bottom: '#main-sidebar',
    partial: 'spree/admin/shared/analytics_sidebar_menu'
  )
end
