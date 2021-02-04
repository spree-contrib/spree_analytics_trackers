module SpreeAnalyticsTrackers
  module UserPasswordsControllerDecorator
    def self.included(base)
      base.helper 'spree/trackers'
    end
  end
end

if defined?(Spree::UserPasswordsController)
  ::Spree::UserPasswordsController.include(::SpreeAnalyticsTrackers::UserPasswordsControllerDecorator)
end
