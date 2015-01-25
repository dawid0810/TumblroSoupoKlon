class AddOrderToImage < ActiveRecord::Migration
  def change
    add_column :images, :order, :bigint
  end
end
