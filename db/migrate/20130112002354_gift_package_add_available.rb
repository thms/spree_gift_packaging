class GiftPackageAddAvailable < ActiveRecord::Migration
  def up
    add_column :spree_gift_packages, :available, :boolean, :null => false, :default => true
    Spree::GiftPackage.all do |gift_package|
      gift_package.update_attribute(:available, true)
    end
  end

  def down
    remove_column :spree_gift_packages, :available
  end
end
