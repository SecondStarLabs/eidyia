class AddStreetOneToSchool < ActiveRecord::Migration[6.0]
  def change
    add_column :schools, :street_one, :string
  end
end
