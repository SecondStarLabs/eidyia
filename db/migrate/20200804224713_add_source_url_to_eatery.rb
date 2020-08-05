class AddSourceUrlToEatery < ActiveRecord::Migration[6.0]
  def change
    add_column :eateries, :source_url, :text
  end
end
