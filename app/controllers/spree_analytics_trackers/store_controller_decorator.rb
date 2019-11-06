module SpreeAnalyticsTrackers
  module StoreControllerDecorator
    def self.included(base)
      base.include ::Spree::TrackersHelper

      base.helper_method *::Spree::TrackersHelper.public_instance_methods
    end
  end
end

if defined?(Spree::StoreController)
  ::Spree::StoreController.include(::SpreeAnalyticsTrackers::StoreControllerDecorator)
end
