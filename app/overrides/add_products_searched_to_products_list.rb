Deface::Override.new(
  virtual_path: 'spree/shared/_products',
  name: 'add_products_searched_to_products_list',
  insert_before: "[data-hook='products_search_results_heading']",
  partial: 'spree/shared/trackers/segment/products_searched.js',
  original: '8b47dddca9dfaaacca3d462459c6c1ef06c09926'
)
