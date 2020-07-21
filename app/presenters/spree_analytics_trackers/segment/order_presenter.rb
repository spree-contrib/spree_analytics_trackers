module SpreeAnalyticsTrackers
  module Segment
    class OrderPresenter < SpreeAnalyticsTrackers::BasePresenter
      private

      def serialize_resource(resource, options = {})
        {
          order_id: resource.number.to_s,
          total: resource.total&.to_f,
          shipping: resource.shipment_total&.to_f,
          tax: resource.additional_tax_total&.to_f,
          discount: resource.promo_total&.to_f,
          coupon: resource.promo_code,
          currency: resource.currency,
          products: resource.line_items.map { |li| serialize_line_item(li) }
        }
      end

      private

      def serialize_line_item(line_item)
        {
          product_id: line_item.product_id&.to_s,
          sku: line_item.sku&.to_s,
          name: line_item.name,
          price: line_item.price&.to_f,
          quantity: line_item.quantity
        }
      end
    end
  end
end
