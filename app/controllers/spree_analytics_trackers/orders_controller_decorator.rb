module SpreeAnalyticsTrackers
  module OrdersControllerDecorator
    def self.included(base)
      base.helper 'spree/trackers'
    end
  end
end

if defined?(Spree::OrdersController)
  ::Spree::OrdersController.include(::SpreeAnalyticsTrackers::OrdersControllerDecorator)
end
