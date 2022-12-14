class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|

      t.integer :price_including_tax
      t.integer :quantity, null: false
      t.integer :production_status, default: 0, null: false, limit: 1

      t.integer :order_id
      t.integer :item_id

      t.timestamps
    end
  end
end
