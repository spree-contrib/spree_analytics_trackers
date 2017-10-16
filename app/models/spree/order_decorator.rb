if Gem.loaded_specs['spree_core'].version < Gem::Version.create('3.3.0')
  Spree::Order.class_eval do
    def promo_code
      promotions.pluck(:code).compact.first
    end
  end
end
