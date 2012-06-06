Deface::Override.new(:virtual_path => 'spree/admin/configurations/index',
                     :name => 'add_gift_packages_to_admin_configurations_menu',
                     :insert_bottom => "[data-hook='admin_configurations_menu']",
                     :text => %q{
                        <tr>
                          <td><%= link_to 'Gift Packaging', admin_gift_packages_path %></td>
                          <td>Manage Gift Packaging</td>
                        </tr> },
                      :disabled => false)
                      

Deface::Override.new(:virtual_path => 'spree/admin/shipments/_form',
                      :name => 'add_gift_packaging_to_shipment_form',
                      :insert_before => "[data-hook='admin_shipment_form_address']",
                      :partial => 'spree/admin/shipments/gift_packaging',
                      :diabled => false)
                      
                      
                                            