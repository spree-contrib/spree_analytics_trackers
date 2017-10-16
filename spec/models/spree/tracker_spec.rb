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
  end
end
