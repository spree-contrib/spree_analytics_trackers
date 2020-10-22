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

Spree.ready(function(){
  $('body').on('product_remove_from_cart', function(event) {
    var variant = {
      sku: event.variant_sku,
      name: event.variant_name,
      price: event.variant_price,
      options: event.variant_options,
      quantity: event.variant_quantity
    }

    if (typeof gtag !== 'undefined') {
      gaRemoveFromCart(variant)
    }
  })
})
