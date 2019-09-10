module SpreeAnalyticsTrackers
  module UserDecorator
    def analytics_id
      id
    end
  end
end

::Spree.user_class.prepend(::SpreeAnalyticsTrackers::UserDecorator)
