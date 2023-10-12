spree_version = Gem.loaded_specs['spree_core'].version
unless spree_version >= Gem::Version.create('3.4.0') && spree_version < Gem::Version.create('3.5.0')
  Deface::Override.new(
    virtual_path: 'spree/shared/_products',
    name: 'add_product_list_viewed_to_products_list',
    insert_before: '[data-hook="homepage_products"]',
    text: <<-HTML
      <%= render partial: 'spree/shared/trackers/segment/product_list_viewed', formats: :js %>
    HTML
  )
end
