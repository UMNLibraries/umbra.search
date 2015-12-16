class UpsertRecords
  def self.call(records)
    upserts = []
    records.each do |record|
      upserts << Record.new(record)
    end
    Record.import upserts, :on_duplicate_key_update => [:metadata, :ingest_name, :ingest_hash, :data_provider_id]
  end
end