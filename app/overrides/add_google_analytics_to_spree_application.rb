Deface::Override.new(
  virtual_path: 'spree/layouts/spree_application',
  name: 'add_google_analytics_initializer_to_spree_application',
  insert_top: "[data-hook='inside_head']",
  partial: 'spree/shared/trackers/google_analytics/initializer.js'
)

Deface::Override.new(
  virtual_path: 'spree/layouts/checkout',
  name: 'add_google_analytics_initializer_to_spree_checkout',
  insert_top: "[data-hook='inside_head']",
  partial: 'spree/shared/trackers/google_analytics/initializer.js'
)
