class CreateEateries < ActiveRecord::Migration[6.0]
  def change
    create_table :eateries do |t|
      t.string :name
      t.decimal :rating
      t.integer :no_of_reviews
      t.string :address
      t.string :street_one
      t.string :street_two
      t.belongs_to :city, null: false, foreign_key: true
      t.integer :min_wait
      t.integer :max_wait
      t.decimal :delivery

      t.timestamps
    end
  end
end
