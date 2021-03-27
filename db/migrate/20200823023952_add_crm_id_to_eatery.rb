class AddCrmIdToEatery < ActiveRecord::Migration[6.0]
  def change
    add_column :eateries, :crm_id, :integer
  end
end
