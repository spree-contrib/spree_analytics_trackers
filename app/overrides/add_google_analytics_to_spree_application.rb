if Gem.loaded_specs['spree_core'].version >= Gem::Version.create('3.5.0.alpha')
  Deface::Override.new(
    virtual_path: 'spree/shared/_head',
    name: 'add_google_analytics_initializer_to_spree_application',
    insert_after: 'title',
    text: <<-HTML
      <%= render partial: 'spree/shared/trackers/google_analytics/initializer', formats: :js %>
    HTML
  )
end
