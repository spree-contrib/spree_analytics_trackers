module Spree
  module TrackersHelper
    def product_for_segment(product, optional = {})
      {
        product_id: product.id,
        sku: product.sku,
        category: product.category.try(:name),
        name: product.name,
        brand: product.brand.try(:name),
        price: product.price.to_f,
        currency: product.currency,
        url: product_url(product),
      }.tap do |hash|
        # This method returns either asset_url (Paperclip) or rails_blob_path (ActiveStorage) to return the specified image(s)
        if defined?(ActiveStorage) && !Rails.application.config.use_paperclip
          hash[:image_url] =  request.base_url + Rails.application.routes.url_helpers.rails_blob_path(optional.delete(:image).attachment, only_path: true) if optional[:image]
        else
          hash[:image_url] = request.base_url + asset_url(optional.delete(:image).attachment) if optional[:image]
        end
      end.merge(optional).to_json.html_safe
    end
  end
end
