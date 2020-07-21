require 'spec_helper'

describe 'Analytics Tracker', type: :feature do
  stub_authorization!

  let!(:default_store) { Spree::Store.default }
  let!(:another_store) { create(:store, name: 'Eurozone') }

  context 'index' do
    before(:each) do
      create(:tracker, store: default_store)
      create(:tracker, analytics_id: 'A200', store: another_store)
      visit spree.admin_trackers_path
    end

    it 'should have the right content' do
      expect(page).to have_content('Analytics Trackers')
    end

    it 'should have the right tabular values displayed' do
      within_row(1) do
        expect(column_text(1)).to eq('A100')
        expect(column_text(2)).to eq('Google analytics')
        expect(column_text(3)).to eq(default_store.name)
        expect(column_text(4)).to eq('Yes')
      end

      within_row(2) do
        expect(column_text(1)).to eq('A200')
        expect(column_text(2)).to eq('Google analytics')
        expect(column_text(3)).to eq('Eurozone')
        expect(column_text(4)).to eq('Yes')
      end
    end
  end

  context 'create' do
    before(:each) do
      visit spree.admin_trackers_path
    end

    it 'should be able to create a new analytics tracker', js: true do
      within('.content-header') do
        click_link 'admin_new_tracker_link'
      end
      fill_in 'tracker_analytics_id', with: 'A100'

      select2 default_store.name, from: 'Store'

      click_button 'Create'

      expect(page).to have_content('successfully created!')
      within_row(1) do
        expect(column_text(1)).to eq('A100')
        expect(column_text(2)).to eq('Google analytics')
        expect(column_text(3)).to eq(default_store.name)
        expect(column_text(4)).to eq('Yes')
      end
    end
  end
end
