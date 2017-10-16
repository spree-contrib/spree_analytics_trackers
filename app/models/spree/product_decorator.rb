if Gem.loaded_specs['spree_core'].version < Gem::Version.create('3.2.0')
  Spree::Product.class_eval do
    def category
      taxons.joins(:taxonomy).find_by(spree_taxonomies: { name: Spree.t(:taxonomy_categories_name) })
    end

    def brand
      taxons.joins(:taxonomy).find_by(spree_taxonomies: { name: Spree.t(:taxonomy_brands_name) })
    end
  end
end
