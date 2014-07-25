class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.string :image_url
      t.decimal :price, precision: 8, scale: 2
      t.decimal :discount_price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
