spree_version = Gem.loaded_specs['spree_core'].version
unless spree_version >= Gem::Version.create('3.4.0') && spree_version < Gem::Version.create('3.5.0')
  Deface::Override.new(
    virtual_path: 'spree/taxons/_header',
    name: 'add_product_list_filtered_to_taxons_show',
    insert_before: ".taxon-title",
    text: <<-HTML
      <%= render partial: 'spree/shared/trackers/segment/product_list_filtered', formats: :js %>
    HTML
  )
end
