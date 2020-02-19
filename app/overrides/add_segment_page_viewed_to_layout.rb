Deface::Override.new(
  virtual_path: 'spree/layouts/spree_application',
  name: 'add_segment_page_tracker_to_body',
  insert_bottom: "[data-hook='body']",
  partial: 'spree/shared/trackers/segment/page_viewed.js',
  original: '6841b819babbe4df1f03d0bc8e05dc81bf0d45ad'
)

Deface::Override.new(
  virtual_path: 'spree/layouts/checkout',
  name: 'add_segment_page_tracker_to_spree_checkout',
  insert_bottom: "[data-hook='body']",
  partial: 'spree/shared/trackers/segment/page_viewed.js',
  original: '6841b819babbe4df1f03d0bc8e05dc81bf0d45ad'
)
