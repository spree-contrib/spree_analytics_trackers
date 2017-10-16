if Gem.loaded_specs['spree_core'].version < Gem::Version.create('3.2.0')
  Spree::LineItem.class_eval do
    delegate :brand, :category, to: :product
    delegate :options_text, to: :variant
  end
end
