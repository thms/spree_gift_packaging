Deface::Override.new(:virtual_path => "spree/shared/_order_details",
	                   :name => "order_details_gift_packaging",
	                   :insert_before => "[data-hook='order_details_adjustments']",
	                   :sequence => 20,
	                   :partial => "spree/orders/order_details_add_gift_packaging",
	                   :disabled => false)
