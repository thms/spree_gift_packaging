# Make sure only eligible adjustments show on the edit form in admin
Deface::Override.new(:virtual_path => "spree/admin/orders/_form",
                     :name => "admin_orders_adjustments",
                     :replace => "[data-hook='admin_order_form_adjustments']",
                     :partial => "/spree/admin/orders/form_adjustments",
                     :disabled => false)
