Deface::Override.new(:virtual_path => "spree/products/_cart_form",
	                   :name => "product_detail_gift_packaging_form",
	                   :insert_top => "[data-hook='inside_product_cart_form']",
	                   :sequence => 20,
	                   :partial => "spree/products/gift_packaging_form",
	                   :disabled => false)
