class CreateGiftPackages < ActiveRecord::Migration
  def change
    create_table :spree_gift_packages do |t|
      t.string  :title, :null => false, :default => ''
      t.text    :description, :null => false, :default => ''
      t.string  :image_file_name
      t.string  :image_content_type
      t.integer :image_file_size
      
      t.timestamps
    end
  end


end
