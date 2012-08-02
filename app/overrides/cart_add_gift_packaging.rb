Deface::Override.new(:virtual_path => "spree/orders/_line_item",
                     :name => "cart_add_gift_packaging_selector",
                     :insert_after => "[data-hook='cart_item_description']",
                     :partial => "spree/orders/cart_gift_packaging_selector",
                     :disabled => false)

Deface::Override.new(:virtual_path => "spree/orders/edit",
                    :name => "cart_add_gift_packaging_total",
                    :insert_top => "#subtotal",
                    :partial => "spree/orders/cart_gift_packaging_total",
                    :disabled => false)

Deface::Override.new(:virtual_path => "spree/orders/_form",
                    :name => "cart_add_gift_packaging_total",
                    :replace => "#cart-detail",
                    :partial => "spree/orders/cart_detail_table",
                    :disabled => false)

Deface::Override.new(:virtual_path => "spree/checkout/_summary",
                      :name => "checkout_summary_add_gift_packaging",
                      :insert_top => "#summary-order-charges",
                      :partial => "spree/checkout/gift_packaging_to_summary",
                      :disabled => false)