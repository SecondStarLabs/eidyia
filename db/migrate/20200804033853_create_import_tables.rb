class CreateImportTables < ActiveRecord::Migration[6.0]
  def change
    create_table :import_tables do |t|
      t.string :original_path

      t.timestamps
    end
  end
end
