if defined?(Spree::StoreController)
  Spree::StoreController.class_eval do
    helper Spree::TrackersHelper
  end
end
