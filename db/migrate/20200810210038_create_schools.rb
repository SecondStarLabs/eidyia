class CreateSchools < ActiveRecord::Migration[6.0]
  def change
    create_table :schools do |t|
      t.text :schooldigger_link
      t.string :name
      t.string :kind
      t.string :grades
      t.string :district
      t.text :schooldigger_district_link
      t.integer :enrollment
      t.float :student_teacher_ratio
      t.float :free_discounted_lunch_recipients
      t.float :school_digger_rating
      t.string :schooldigger_id

      t.timestamps
    end
  end
end
