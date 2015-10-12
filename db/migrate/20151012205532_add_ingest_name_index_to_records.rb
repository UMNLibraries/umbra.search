class AddIngestNameIndexToRecords < ActiveRecord::Migration
  def change
    add_index :records, :ingest_name
  end
end
