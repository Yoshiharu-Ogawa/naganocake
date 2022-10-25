class CreateOrderDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :order_details do |t|

      t.integer :price_including_tax
      t.integer :quantity
      t.integer :production_status, default: 0, null: false, limit: 1

      t.timestamps
    end
  end
end
