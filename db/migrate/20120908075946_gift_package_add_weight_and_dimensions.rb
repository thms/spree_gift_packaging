class GiftPackageAddWeightAndDimensions < ActiveRecord::Migration
  def up
    add_column :spree_gift_packages, :weight, :decimal, :precision => 8, :scale => 2, :default => 0.0, :null => false
    add_column :spree_gift_packages, :height, :decimal, :precision => 8, :scale => 2, :default => 0.0, :null => false
    add_column :spree_gift_packages, :width, :decimal, :precision => 8, :scale => 2, :default => 0.0, :null => false
    add_column :spree_gift_packages, :depth, :decimal, :precision => 8, :scale => 2, :default => 0.0, :null => false
  end

  def down
    remove_column :spree_gift_packages, :weight
    remove_column :spree_gift_packages, :height
    remove_column :spree_gift_packages, :width
    remove_column :spree_gift_packages, :depth
  end
end
