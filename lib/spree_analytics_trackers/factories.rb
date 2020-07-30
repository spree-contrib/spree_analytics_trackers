unless FactoryBot.factories.registered?(:tracker)
  FactoryBot.define do
    factory :tracker, class: Spree::Tracker do
      analytics_id { 'A100' }
      active { true }
      engine { :google_analytics }
      store { Spree::Store.default || create(:store) }
    end
  end
end
