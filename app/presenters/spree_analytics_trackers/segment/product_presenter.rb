module SpreeAnalyticsTrackers
  module Segment
    class ProductPresenter < SpreeAnalyticsTrackers::BasePresenter
      private

      def serialize_resource(resource, options = {})
        {
          resource_id: resource.id.to_s,
          sku: resource.sku&.to_s,
          category: resource.category&.name,
          name: resource.name,
          brand: brand_name,
          price: resource.price_in(current_currency).amount&.to_f,
          currency: current_currency,
          url: resource_url(resource)
        }.tap do |hash|
          hash[:image_url] = segment_image_url(hash, options)
        end.merge(options)
      end

      def segment_image_url(hash, options)
        
      end

      def brand_name
        resource.vendor.name if defined?(SpreeMultiVendor) && resource.defined?(:vendor) && resource.vendor.present?
        
        resource.brand&.name
      end

      def current_currency
        @current_currency ||= options[:current_currency]
      end

      def locale
        @locale ||= options[:locale]
      end
    end
  end
end
