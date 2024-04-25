spree_version = Gem.loaded_specs['spree_core'].version
unless spree_version >= Gem::Version.create('3.4.0') && spree_version < Gem::Version.create('3.5.0')
  Deface::Override.new(
    virtual_path: 'spree/addresses/new_wholesale',
    name: 'add_google_analytics_contact_info_added_to_store_address',
    insert_bottom: '[data-hook="new_wholesale_address"]',
    text: <<-HTML
      <%= render partial: 'spree/shared/trackers/google_analytics/contact_info_added', formats: :js %>
    HTML
  )
end
