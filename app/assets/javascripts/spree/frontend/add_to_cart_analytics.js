//= require spree/frontend

function gaAddToCart(variant, quantity) {
  clearGAplugins();
  var price = typeof variant.price === 'object' ? variant.price.amount : variant.price
  gtag(
    'event',
    'add_to_cart',
    {
      items: [{
        id: variant.sku,
        name: variant.name,
        category: variant.category,
        variant: variant.options_text,
        brand: variant.brand,
        price: price,
        quantity: quantity
      }]
    }
  );
}

function fbAddToCart(variant, currency) {
  var price = typeof variant.price === 'object' ? variant.price.amount : variant.price
  fbq('track', 'AddToCart', {
    content_name: variant.name,
    content_category: variant.category,
    content_ids: [variant.id],
    content_type: 'product',
    value: price,
    currency: currency
  });
}

function segmentAddtoCart(variant, quantity, currency) {
  analytics.track('Product Added', {
    product_id: variant.id,
    sku: variant.sku,
    category: variant.category,
    name: variant.name,
    brand: variant.brand,
    price: variant.price,
    currency: currency,
    quantity: quantity
  });
}

Spree.ready(function(){
  $('body').on('product_add_to_cart', function(event) {
    var variant = event.variant
    var quantity = event.quantity_increment
    var currency = event.cart.currency

    if (typeof fbq !== 'undefined') {
      fbAddToCart(variant, currency)
    }

    if (typeof gtag !== 'undefined') {
      gaAddToCart(variant, quantity)
    }

    if (typeof analytics !== 'undefined') {
      segmentAddtoCart(variant, quantity, currency)
    }
  })
});
