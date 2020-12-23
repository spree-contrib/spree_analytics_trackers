spree_version = Gem.loaded_specs['spree_core'].version
unless spree_version >= Gem::Version.create('3.4.0') && spree_version < Gem::Version.create('3.5.0')
  Deface::Override.new(
    virtual_path: 'spree/users/show',
    name: 'add_registration_lead_success',
    insert_before: '[data-hook="account_my_orders"]',
    partial: 'spree/shared/trackers/leads/signup_success.html',
    original: '8b47dddca9dfaaacca3d462459c6c1ef06dc09924'
  )
end
