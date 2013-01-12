class GiftPackageAddIsDefault < ActiveRecord::Migration
  def up
    add_column :spree_gift_packages, :is_default, :boolean, :null => false, :default => false
    Spree::GiftPackage.all do |gift_package|
      gift_package.update_attribute(:is_default, gift_package.title.downcase.include?('suede'))
    end
  end

  def down
    remove_column :spree_gift_packages, :is_default
  end
end
