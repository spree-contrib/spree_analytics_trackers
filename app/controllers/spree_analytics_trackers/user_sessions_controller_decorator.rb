module SpreeAnalyticsTrackers
  module UserSessionsControllerDecorator
    def self.included(base)
      base.include ::Spree::TrackersHelper

      base.helper_method *::Spree::TrackersHelper.public_instance_methods
    end
  end
end

if defined?(Spree::UserSessionsController)
  ::Spree::UserSessionsController.include(::SpreeAnalyticsTrackers::UserSessionsControllerDecorator)
end
