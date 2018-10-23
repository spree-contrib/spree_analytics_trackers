spree_version = Gem.loaded_specs['spree_core'].version
unless spree_version >= Gem::Version.create('3.4.0') && spree_version < Gem::Version.create('3.5.0')
  Deface::Override.new(
    virtual_path: 'spree/products/show',
    name: 'add_product_viewed_to_products_show',
    insert_before: "[data-hook='product_show']",
    partial: 'spree/shared/trackers/segment/product_viewed.js',
    original: '5426c263ccfe477b270b55024abebc77cf951c91' 
  )
end
