module Spree
  class Tracker < Spree::Base
    TRACKING_ENGINES = %i(google_analytics segment).freeze
    enum engine: TRACKING_ENGINES

    after_commit :clear_cache

    validates :analytics_id, presence: true, uniqueness: { scope: [:engine, :store_id], case_sensitive: false }
    validates :store, presence: true

    scope :active, -> { where(active: true) }

    belongs_to :store

    def self.current(engine = nil, store = nil)
      engine ||= TRACKING_ENGINES.first
      store  ||= Spree::Store.default

      tracker = Rails.cache.fetch("current_tracker/#{engine}/#{store.id}") do
        active.find_by(store: store, engine: engine)
      end
      tracker.analytics_id.present? ? tracker : nil if tracker
    end

    def clear_cache
      TRACKING_ENGINES.each do |engine|
        Rails.cache.delete("current_tracker/#{engine}/#{store_id}")
      end
    end
  end
end
