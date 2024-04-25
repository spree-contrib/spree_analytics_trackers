spree_version = Gem.loaded_specs['spree_core'].version
unless spree_version >= Gem::Version.create('3.4.0') && spree_version < Gem::Version.create('3.5.0')
  Deface::Override.new(
    virtual_path: 'spree/user_registrations/new',
    name: 'add_google_analytics_begin_application_to_registration',
    insert_bottom: '[data-hook="wholesale_login_extras"]',
    text: <<-HTML
      <%= render partial: 'spree/shared/trackers/google_analytics/begin_application', formats: :js %>
    HTML
  )
end
