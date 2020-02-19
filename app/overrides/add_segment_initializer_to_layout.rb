Deface::Override.new(
  virtual_path: 'spree/layouts/spree_application',
  name: 'add_segment_initializer_to_layout',
  insert_bottom: "[data-hook='inside_head']",
  partial: 'spree/shared/trackers/segment/initializer.js',
  original: '6841b819babbe4df1f03d0bc8e05dc81bf0d45ad'
)

Deface::Override.new(
  virtual_path: 'spree/layouts/checkout',
  name: 'add_segment_initializer_to_spree_checkout',
  insert_bottom: "[data-hook='inside_head']",
  partial: 'spree/shared/trackers/segment/initializer.js',
  original: '6841b819babbe4df1f03d0bc8e05dc81bf0d45ad'
)
