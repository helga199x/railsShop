class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :client_id
      t.integer :good_id
      t.integer :amount
      t.float :price
      t.integer :order_number
      t.timestamps
    end
  end
end
