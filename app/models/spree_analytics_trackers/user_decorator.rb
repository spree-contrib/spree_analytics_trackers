module SpreeAnalyticsTracker
  module UserDecorator
    def analytics_id
      id
    end
  end
end

::Spree.user_class.prepend(::SpreeAnalyticsTracker::UserDecorator)
