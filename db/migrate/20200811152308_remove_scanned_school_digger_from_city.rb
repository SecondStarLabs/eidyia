class RemoveScannedSchoolDiggerFromCity < ActiveRecord::Migration[6.0]
  def change
    remove_column :cities, :scanned_school_digger, :boolean
  end
end
