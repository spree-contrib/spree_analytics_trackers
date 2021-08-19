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
    const variant = {
      cart_id: event.cart ? event.cart.number : null,
      sku: event.variant ? event.variant.sku : event.variant_sku,
      id: event.variant ? event.variant.id : null,
      price: event.variant ? event.variant.price.amount : event.variant_price,
      currency: event.variant ? event.variant.price.currency : 'CLP',
      quantity: event.variant ? event.variant.variant_quantity : event.variant_quantity
    }

    if (typeof gtag !== 'undefined') {
      //gaRemoveFromCart(variant)
    }

    if (typeof analytics !== 'undefined') {
      segmentRemoveFromCart(variant)
    }
  })
})
