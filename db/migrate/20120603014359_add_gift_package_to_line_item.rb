class AddGiftPackageToLineItem < ActiveRecord::Migration
  def up
    add_column :spree_line_items, :use_gift_packaging, :boolean, :null => false, :default => false
  end


  def down
    remove_column :spree_line_items, :use_gift_packaging
  end
end
