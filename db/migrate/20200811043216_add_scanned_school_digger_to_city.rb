class AddScannedSchoolDiggerToCity < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :scanned_school_digger, :boolean
  end
end
