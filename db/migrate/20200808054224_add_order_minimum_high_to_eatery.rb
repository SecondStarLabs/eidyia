class AddOrderMinimumHighToEatery < ActiveRecord::Migration[6.0]
  def change
    add_column :eateries, :order_minimum_high, :decimal
  end
end
