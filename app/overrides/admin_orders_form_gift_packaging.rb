# Add gift packaging changes to admin UI
Deface::Override.new(:virtual_path => "spree/admin/orders/_form",
                     :name => "admin_orders_line_item_container",
                     :replace => "#line-items",
                     :partial => "/spree/admin/orders/form_line_items_container",
                     :disabled => false)

Deface::Override.new(:virtual_path => "spree/admin/orders/_form",
                    :name => "admin_orders_sub_total",
                    :replace => "#subtotal",
                    :partial => "/spree/admin/orders/form_subtotal",
                    :disabled => false)

Deface::Override.new(:virtual_path => "spree/admin/orders/_form",
                    :name => "admin_orders_total",
                    :replace => "#order-total",
                    :partial => "/spree/admin/orders/form_total",
                    :disabled => false)

