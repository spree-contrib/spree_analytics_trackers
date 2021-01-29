require 'spec_helper'

describe 'Visiting Login page', type: :feature, js: true do
  it 'is available' do
    expect { visit spree.login_path }.not_to raise_error
  end
end
