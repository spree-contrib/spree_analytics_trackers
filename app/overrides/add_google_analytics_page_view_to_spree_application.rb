spree_version = Gem.loaded_specs['spree_core'].version
unless spree_version >= Gem::Version.create('3.3.0') && spree_version < Gem::Version.create('3.5.0') && spree_version != Gem::Version.create('3.5.0.alpha')
  Deface::Override.new(
    virtual_path: 'spree/shared/_head',
    name: 'add_google_analytics_page_viewed_to_spree_application',
    insert_before: 'meta',
    text: <<-HTML
      <%= render partial: 'spree/shared/trackers/google_analytics/page_viewed', formats: :js %>
    HTML
  )
end
