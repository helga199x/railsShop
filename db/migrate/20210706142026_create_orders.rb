class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :id_client
      t.integer :id_good
      t.timestamps
    end
  end
end
