class AddIngestNameIndexToRecords < ActiveRecord::Migration
  def change
    add_index :records, :ingest_name, name: :ingest_name, :length => { :trip_cities => 255 }
  end
end
