module SpreeAnalyticsTrackers
  module UserConfirmationsControllerDecorator
    def self.included(base)
      base.helper 'spree/trackers'
    end
  end
end

if defined?(Spree::UserConfirmationsController)
  ::Spree::UserConfirmationsController.include(::SpreeAnalyticsTrackers::UserConfirmationsControllerDecorator)
end
