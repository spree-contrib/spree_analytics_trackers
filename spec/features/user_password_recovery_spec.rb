require 'spec_helper'

describe 'Visiting Registation page', type: :feature, js: true do
  it 'is available' do
    expect { visit spree.recover_password_path }.not_to raise_error
  end
end
