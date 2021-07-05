class CreateGoods < ActiveRecord::Migration[6.0]
  def change
    create_table :goods do |t|
      t.string :name
      t.float :price
      t.float :weight
      t.string :discription
      t.string :img
      t.boolean :insale
      t.timestamps
    end
  end
end
