module SpreeAnalyticsTrackers
  module Segment
    class OrderPresenter < SpreeAnalyticsTrackers::BasePresenter
      private

      def serialize_resource(resource)
        {
          order_id: resource.number.to_s,
          total: resource.total,
          shipping: resource.shipment_total,
          tax: resource.additional_tax_total,
          discount: resource.promo_total,
          coupon: resource.promo_code,
          currency: resource.currency,
          products: resource.line_items.map(&:serialize_line_item)
        }
      end

      private

      def serialize_line_item(line_item)
        {
          product_id: line_item.product_id.to_s,
          sku: line_item.sku.to_s,
          name: line_item.name,
          price: line_item.price,
          quantity: line_item.quantity
        }
      end
    end
  end
end
