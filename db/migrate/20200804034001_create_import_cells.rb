class CreateImportCells < ActiveRecord::Migration[6.0]
  def change
    create_table :import_cells do |t|
      t.belongs_to :import_table, null: false, foreign_key: true
      t.integer :row_index
      t.integer :column_index
      t.string :contents

      t.timestamps
    end
  end
end
