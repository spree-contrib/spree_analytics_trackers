module SpreeAnalyticsTrackers
  module UserSessionsControllerDecorator
    def self.included(base)
      base.helper 'spree/trackers'
    end
  end
end

if defined?(Spree::UserSessionsController)
  ::Spree::UserSessionsController.include(::SpreeAnalyticsTrackers::UserSessionsControllerDecorator)
end
