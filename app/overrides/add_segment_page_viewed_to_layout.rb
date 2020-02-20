Deface::Override.new(
  virtual_path: 'spree/layouts/spree_application',
  name: 'add_segment_page_tracker_to_body',
  insert_bottom: "[data-hook='body']",
  partial: 'spree/shared/trackers/segment/page_viewed.js'
)

Deface::Override.new(
  virtual_path: 'spree/layouts/checkout',
  name: 'add_segment_page_tracker_to_spree_checkout',
  insert_bottom: "[data-hook='body']",
  partial: 'spree/shared/trackers/segment/page_viewed.js'
)
