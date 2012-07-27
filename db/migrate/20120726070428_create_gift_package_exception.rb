class CreateGiftPackageException < ActiveRecord::Migration
  def change
    create_table :spree_gift_package_exceptions do |t|
      t.references :gift_package
      t.references :product
    end
  end

end
