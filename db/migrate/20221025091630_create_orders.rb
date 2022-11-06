class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|

      t.string :delivery_postal_code, null: false
      t.string :delivery_address, null: false
      t.string :delivery_name, null: false
      t.integer :total_payment
      t.integer :freight
      t.integer :payment_method, default: 0, null: false, limit: 1
      t.integer :order_status, default: 0, null: false, limit: 1
      
      t.integer :customer_id

      t.timestamps
    end
  end
end
