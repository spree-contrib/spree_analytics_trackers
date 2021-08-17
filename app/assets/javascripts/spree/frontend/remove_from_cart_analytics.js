//= require spree/frontend

function gaRemoveFromCart(variant) {
  clearGAplugins();
  gtag(
    'event',
    'remove_from_cart',
    {
      items: [{
        id: variant.sku,
        name: variant.name,
        price: variant.price,
        variant: variant.options,
        quantity: variant.quantity
      }]
    }
  );
}

function segmentRemoveFromCart(variant) {
  analytics.track('Product Removed', variant);
}

Spree.ready(function(){
  $('body').on('product_remove_from_cart', function(event) {
    var variant = {
      cart_id: event.cart.number,
      sku: event.variant.sku,
      id: event.variant.id,
      price: event.variant.price.amount,
      currency: event.variant.price.currency,
      quantity: event.variant.variant_quantity  || event.quantity
    }

    if (typeof gtag !== 'undefined') {
      //gaRemoveFromCart(variant)
    }

    if (typeof analytics !== 'undefined') {
      segmentRemoveFromCart(variant)
    }
  })
})