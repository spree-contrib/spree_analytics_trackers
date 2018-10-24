if Gem.loaded_specs['spree_core'].version >= Gem::Version.create('3.5.0')
  Deface::Override.new(
    virtual_path: 'spree/checkout/edit',
    name: 'add_google_checkout_to_checkout_edit',
    insert_before: "#checkout",
    partial: 'spree/shared/google_checkout',
    original: '1bc9409097210501fee61bc448df937682546308' 
  )
end
