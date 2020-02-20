Deface::Override.new(
  virtual_path: 'spree/checkout/edit',
  name: 'add_segment_checkout_step_viewed_to_checkout_edit',
  insert_after: "[data-hook='checkout_content']",
  partial: 'spree/shared/trackers/segment/checkout_step_viewed.js'
)

Deface::Override.new(
  virtual_path: 'spree/checkout/edit',
  name: 'add_ga_checkout_step_viewed_to_checkout_edit',
  insert_after: "[data-hook='checkout_content']",
  partial: 'spree/shared/trackers/google_analytics/checkout_step_viewed.js'
)
