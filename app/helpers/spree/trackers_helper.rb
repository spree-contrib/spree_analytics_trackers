module Spree
  module TrackersHelper
    def product_for_segment(product, optional = {})
      {
        product_id: product.id,
        sku: product.sku,
        category: product.category&.name,
        name: product.name,
        brand: product.brand&.name,
        price: product.price.to_f,
        currency: product.currency,
        url: product_url(product)
      }.tap do |hash|
        hash[:image_url] = product_for_segment_image_url(hash, optional)
      end.merge(optional).to_json.html_safe
    end

    def ga_line_item(line_item)
      variant = line_item.variant

      {
        id: variant.sku,
        name: variant.name,
        category: variant.product.category&.name,
        variant: variant.options_text,
        brand: variant.product.brand&.name,
        quantity: line_item.quantity,
        price: variant.price
      }.to_json.html_safe
    end

    private

    # This method returns either asset_url (Paperclip) or rails_blob_path (ActiveStorage) to return the specified image(s)
    def product_for_segment_image_url(hash, optional)
      return unless optional[:image]

      # Spree 4.0 dropped Paperclip support
      if Gem.loaded_specs['spree_core'].version >= Gem::Version.create('4.0.0.alpha') || (defined?(ActiveStorage) && !Rails.application.config.use_paperclip)
        request.base_url + Rails.application.routes.url_helpers.rails_blob_path(optional.delete(:image).attachment, only_path: true)
      else
        request.base_url + asset_url(optional.delete(:image).attachment)
      end
    end
  end
end
