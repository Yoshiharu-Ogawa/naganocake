class AddAddressIdToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :address_id, :integer
  end
end
