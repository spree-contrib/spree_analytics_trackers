Deface::Override.new(
  virtual_path: 'spree/layouts/spree_application',
  name: 'add_segment_initializer_to_layout',
  insert_bottom: "[data-hook='inside_head']",
  partial: 'spree/shared/trackers/segment/initializer.js'
)

Deface::Override.new(
  virtual_path: 'spree/layouts/checkout',
  name: 'add_segment_initializer_to_spree_checkout',
  insert_bottom: "[data-hook='inside_head']",
  partial: 'spree/shared/trackers/segment/initializer.js'
)
