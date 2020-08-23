class AddWebsiteToEatery < ActiveRecord::Migration[6.0]
  def change
    add_column :eateries, :website, :text
  end
end
