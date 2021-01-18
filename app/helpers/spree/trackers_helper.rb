module Spree
  module TrackersHelper
    def product_for_segment(product, optional = {})
      cache_key = [
        'spree-segment-product',
        I18n.locale,
        current_currency,
        product.cache_key_with_version
      ].compact.join('/')

      product_hash = Rails.cache.fetch(cache_key) do
        {
          product_id: product.id,
          sku: product.sku,
          category: product.category&.name,
          name: product.name,
          brand: product.brand&.name,
          price: product.price_in(current_currency).amount&.to_f,
          currency: current_currency,
          url: spree.product_url(product)
        }
      end

      product_hash.tap do |hash|
        hash[:image_url] = default_image_for_product_or_variant(product)
      end.merge(optional).to_json.html_safe
    end

    def ga_line_item(line_item)
      variant = line_item.variant

      cache_key = [
        'spree-ga-line-item',
        I18n.locale,
        current_currency,
        line_item.cache_key_with_version,
        variant.cache_key_with_version
      ].compact.join('/')

      Rails.cache.fetch(cache_key) do
        product = line_item.product
        {
          id: variant.sku,
          name: variant.name,
          category: product.category&.name,
          variant: variant.options_text,
          brand: product.brand&.name,
          quantity: line_item.quantity,
          price: variant.price_in(current_currency).amount&.to_f
        }.to_json.html_safe
      end
    end

    def filtering_param_present?(param)
      params.key?(param) && params.fetch(param).present?
    end

    def any_filtering_params?
      filtering_params.any? { |p| filtering_param_present?(p) }
    end

    def filtering_params_with_values
      params_with_values = {}
      filtering_params.each do |param|
        params_with_values[param] = params.fetch(param) if filtering_param_present?(param)
      end
      params_with_values
    end

    def segment_tracker
      @segment_tracker ||= Spree::Tracker.current(:segment, current_store)
    end

    def segment_enabled?
      segment_tracker.present?
    end

    def ga_tracker
      @ga_tracker ||= Spree::Tracker.current(:google_analytics, current_store)
    end

    def ga_enabled?
      ga_tracker.present?
    end
  end
end
