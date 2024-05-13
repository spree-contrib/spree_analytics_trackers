require 'spec_helper'

describe 'Analytics Tracker', type: :feature do
  stub_authorization!

  let!(:default_store) { Spree::Store.default }
  let!(:another_store) { create(:store, name: 'Eurozone') }

  context '#index' do
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

  context '#update' do
    let!(:tracker) { create(:tracker, store: default_store, active: false) }

    context 'with no other active tracker already assigned to store' do
      it 'should be able to toggle the analytics tracker to active', js: true do
        visit spree.edit_admin_tracker_path(tracker)

        choose 'tracker_active_true'
        click_button 'Update'

        expect(page).to have_content('successfully updated!')
        within_row(1) do
          expect(column_text(1)).to eq('A100')
          expect(column_text(2)).to eq('Google analytics')
          expect(column_text(3)).to eq(default_store.name)
          expect(column_text(4)).to eq('Yes')
        end
      end
    end

    context 'with some other active tracker already assigned to store' do
      before do
        create(:tracker, store: default_store, analytics_id: 'A200')
      end

      it 'should not be able to toggle the analytics tracker to active', js: true do
        visit spree.edit_admin_tracker_path(tracker)

        choose 'tracker_active_true'
        click_button 'Update'

        expect(page).to have_content "#{default_store.name} has already assigned an active tracker"
      end
    end
  end

  context '#create' do
    context 'with no other active tracker already assigned to store' do
      it 'should be able to create a new active analytics tracker', js: true do
        visit spree.admin_trackers_path

        within('.content-header') { click_link 'admin_new_tracker_link' }
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

    context 'with some other active tracker already assigned to store' do
      before do
        create(:tracker, store: default_store)
      end

      it 'should not be able to create a new active analytics tracker', js: true do
        visit spree.admin_trackers_path

        within('.content-header') { click_link 'admin_new_tracker_link' }
        fill_in 'tracker_analytics_id', with: 'A200'
        select2 default_store.name, from: 'Store'

        click_button 'Create'

        expect(page).to have_content "#{default_store.name} has already assigned an active tracker"
      end
    end
  end
end
