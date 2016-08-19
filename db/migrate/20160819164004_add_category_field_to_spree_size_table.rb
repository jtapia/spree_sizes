class AddCategoryFieldToSpreeSizeTable < ActiveRecord::Migration
  def change
    add_column :spree_sizes, :category, :string
  end
end
