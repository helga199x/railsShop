class AddColimnsAmountAndPriceToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders , :amount, :string
    add_column :orders , :price, :string
  end
end
