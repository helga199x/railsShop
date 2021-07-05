class AddColumnCategoryToGoods < ActiveRecord::Migration[6.0]
  def change
    add_column :goods , :category, :string
  end
end
