//= require spree/frontend

Spree.ready(function(){
  $('body').on('product_add_to_cart', function(event) {
    var variant = event.variant
    var quantity = event.quantity_increment
    var currency = event.cart.currency

    if (typeof gtag !== 'undefined') {
      gaAddToCart(variant, quantity)
    } else if (typeof analytics !== 'undefined') {
      segmentAddtoCart(variant, quantity)
    }
  })

  function gaAddToCart(variant, quantity) {
    gtag(
      'event',
      'add_to_cart',
      {
        id: variant.sku,
        name: variant.name,
        category: variant.category,
        variant: variant.options_text,
        brand: variant.brand,
        price: variant.price,
        quantity: quantity
      }
    );
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
});
