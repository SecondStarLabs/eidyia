class AddStreetTwoToSchool < ActiveRecord::Migration[6.0]
  def change
    add_column :schools, :street_two, :string
  end
end
