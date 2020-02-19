Deface::Override.new(
  virtual_path: 'spree/admin/shared/sub_menu/_configuration',
  name: 'add_analytics_to_admin_sidebar',
  insert_bottom: '[data-hook="admin_configurations_sidebar_menu"]',
  partial: 'spree/admin/shared/analytics_sidebar_menu'
)
