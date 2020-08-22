class AddSchoolDiggerScanDoneToCity < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :school_digger_scan_done, :decimal, :precision=>6,:scale=>4,:default=>0.0, :null => false
  end
end
