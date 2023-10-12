spree_version = Gem.loaded_specs['spree_core'].version
unless spree_version >= Gem::Version.create('3.3.0') && spree_version < Gem::Version.create('3.5.0') && spree_version != Gem::Version.create('3.5.0.alpha')
  Deface::Override.new(
    virtual_path: 'spree/shared/_head',
    name: 'add_segment_initializer_to_layout',
    insert_after: 'title',
    text: <<-HTML
      <%= render partial: 'spree/shared/trackers/segment/initializer', formats: :js %>
    HTML
  )
end
