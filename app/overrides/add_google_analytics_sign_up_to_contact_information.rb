spree_version = Gem.loaded_specs['spree_core'].version
unless spree_version >= Gem::Version.create('3.4.0') && spree_version < Gem::Version.create('3.5.0')
  Deface::Override.new(
    virtual_path: 'spree/wholesalers/new',
    name: 'add_google_analytics_sign_up_to_contact_information',
    insert_bottom: '[data-hook="wholesaler_inside_form"]',
    text: <<-HTML
      <%= render partial: 'spree/shared/trackers/google_analytics/sign_up', formats: :js %>
    HTML
  )
end
