require 'spec_helper'

describe SpreeAnalyticsTrackers::Segment::OrderPresenter, type: :presenter do
  let(:order) { create(:order_with_line_items) }

  subject { described_class.new(order) }

  describe '#to_json' do
    let(:result) do
      {
        order_id: order.number.to_s,
        total: order.total&.to_f,
        shipping: order.shipment_total&.to_f,
        tax: order.additional_tax_total&.to_f,
        discount: order.promo_total&.to_f,
        coupon: order.promo_code,
        currency: order.currency,
        products: order.line_items.map{ |line_item| 
          {
            product_id: line_item.product_id&.to_s,
            sku: line_item.sku&.to_s,
            name: line_item.name,
            price: line_item.price&.to_f,
            quantity: line_item.quantity
          }
        }
      }.to_json
    end

    it 'returns serialized object' do
      expect(subject.to_json).to eq(result)
    end
  end
end