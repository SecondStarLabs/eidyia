class Crm::SliceLifeBulkImporter
    
    def initialize(importer: Crm::SliceLifeImporter.new, eateries:)
        @importer   = importer
        @eateries   = eateries
    end

    def upload
        @eateries.each do |eatery|
            @importer.upload(eatery: eatery)
        end
    end
end