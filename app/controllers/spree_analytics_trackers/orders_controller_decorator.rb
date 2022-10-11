module SpreeAnalyticsTrackers
  module OrdersControllerDecorator
    def self.included(base)
      base.helper 'spree/trackers'
    end
  end
end

::Spree::OrdersController.prepend(SpreeAnalyticsTrackers::OrdersControllerDecorator) if ::Spree::OrdersController.included_modules.exclude?(SpreeAnalyticsTrackers::OrdersControllerDecorator)
