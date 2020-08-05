class ImportTable < ApplicationRecord
    has_many :import_cells, :dependent => :destroy
end
