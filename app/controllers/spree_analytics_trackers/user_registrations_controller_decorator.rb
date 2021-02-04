module SpreeAnalyticsTrackers
  module UserRegistrationsControllerDecorator
    def self.included(base)
      base.helper 'spree/trackers'
    end
  end
end

if defined?(Spree::UserRegistrationsController)
  ::Spree::UserRegistrationsController.include(::SpreeAnalyticsTrackers::UserRegistrationsControllerDecorator)
end
