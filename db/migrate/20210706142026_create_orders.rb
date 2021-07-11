class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :id_client
      t.integer :id_good
      t.integer :amount
      t.float :price
      t.integer :order_number
      t.timestamps
    end
  end
end
