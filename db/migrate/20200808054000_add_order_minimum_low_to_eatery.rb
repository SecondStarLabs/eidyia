class AddOrderMinimumLowToEatery < ActiveRecord::Migration[6.0]
  def change
    add_column :eateries, :order_minimum_low, :decimal
  end
end
