Rails.application.config.after_initialize do
  if Spree::Core::Engine.backend_available?
     Rails.application.config.spree_backend.main_menu.add_to_section('settings',
      ::Spree::Admin::MainMenu::ItemBuilder.new('admin.analytics', ::Spree::Core::Engine.routes.url_helpers.admin_trackers_path).
        with_manage_ability_check(::Spree::Tracker).
        build
      )
  end
end
