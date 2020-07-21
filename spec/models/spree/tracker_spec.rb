require 'spec_helper'

describe Spree::Tracker, type: :model do
  describe 'current' do
    it 'returns the first active tracker' do
      tracker = create(:tracker)
      tracker.clear_cache
      expect(Spree::Tracker.current).to eq(tracker)
    end

    it 'does not return an inactive tracker' do
      tracker = create(:tracker, active: false)
      tracker.clear_cache
      expect(Spree::Tracker.current).to be_nil
    end

    context 'multi-store' do
      let(:default_store) { Spree::Store.default }
      let(:euro_store) { create(:store, code: :eu, name: 'eurozone') }
      let!(:default_tracker) { create(:tracker, store: default_store, engine: :google_analytics) }
      let!(:euro_tracker) { create(:tracker, store: euro_store, engine: :google_analytics) }

      it 'returns default tracker from default store' do
        expect(Spree::Tracker.current).to eq(default_tracker)
      end

      it 'returns tracker from a specified store' do
        expect(Spree::Tracker.current(:google_analytics, euro_store)).to eq(euro_tracker)
      end
    end
  end
end
