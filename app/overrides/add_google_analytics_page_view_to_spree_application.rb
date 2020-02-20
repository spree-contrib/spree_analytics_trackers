Deface::Override.new(
  virtual_path: 'spree/layouts/spree_application',
  name: 'add_google_analytics_page_viewed_to_spree_application',
  insert_bottom: "[data-hook='body']",
  partial: 'spree/shared/trackers/google_analytics/page_viewed.js'
)

Deface::Override.new(
  virtual_path: 'spree/layouts/checkout',
  name: 'add_google_analytics_page_viewed_to_spree_checkout',
  insert_bottom: "[data-hook='body']",
  partial: 'spree/shared/trackers/google_analytics/page_viewed.js'
)
