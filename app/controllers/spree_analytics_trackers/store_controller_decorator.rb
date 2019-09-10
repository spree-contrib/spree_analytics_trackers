module SpreeAnalyticsTrackers
  module StoreControllerDecorator
    def self.prepended(base)
      base.helper Spree::TrackersHelper
    end
  end
end

if defined?(Spree::StoreController)
  ::Spree::StoreController.prepend(::SpreeAnalyticsTrackers::StoreControllerDecorator)
end
