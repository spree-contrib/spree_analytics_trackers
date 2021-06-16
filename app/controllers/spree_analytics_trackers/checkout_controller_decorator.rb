module SpreeAnalyticsTrackers
  module CheckoutControllerDecorator
    def self.included(base)
      base.include ::Spree::BaseHelper
      base.helper 'spree/trackers'
    end
  end
end

if defined?(Spree::CheckoutController)
  ::Spree::CheckoutController.include(::SpreeAnalyticsTrackers::CheckoutControllerDecorator)
end
