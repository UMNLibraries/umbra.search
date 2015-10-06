class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :record_hash, :unique => true
      t.text   :metadata
      t.string :ingest_name
      t.string :ingest_hash
      t.timestamps null: false
    end
  end
end
