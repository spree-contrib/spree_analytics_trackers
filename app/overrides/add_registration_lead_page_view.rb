spree_version = Gem.loaded_specs['spree_core'].version
unless spree_version >= Gem::Version.create('3.4.0') && spree_version < Gem::Version.create('3.5.0')
  Deface::Override.new(
    virtual_path: 'spree/shared/_user_form',
    name: 'add_registration_lead_page_view',
    insert_before: '[data-hook="signup_below_password_fields"]',
    partial: 'spree/shared/trackers/leads/signup_page_view.html',
    original: '8b47dddca9dfaaacca3d462459c6c1ef06dc09924'
  )
end
