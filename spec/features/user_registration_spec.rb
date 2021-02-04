require 'spec_helper'

describe 'Visiting Registation page', type: :feature, js: true do
  it 'is available' do
    expect { visit spree.signup_path }.not_to raise_error
  end
end
