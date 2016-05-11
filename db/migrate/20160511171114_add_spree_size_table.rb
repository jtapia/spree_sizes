class AddSpreeSizeTable < ActiveRecord::Migration
  def change
    create_table :spree_sizes do |t|
      t.string  :name
      t.string  :description

      t.timestamps
    end
  end
end
