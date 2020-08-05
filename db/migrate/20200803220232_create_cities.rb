class CreateCities < ActiveRecord::Migration[6.0]
  def change
    create_table :cities do |t|
      t.string :city_ascii
      t.string :state_id
      t.string :state_name
      t.integer :county_fips
      t.integer :county_fips_all
      t.string :county_name_all
      t.float :lat
      t.float :lng
      t.integer :population
      t.integer :density
      t.string :source
      t.boolean :military
      t.boolean :incorporated
      t.string :timezone
      t.integer :ranking
      t.string :zips

      t.timestamps
    end
  end
end
