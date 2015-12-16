class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :record_hash, :limit => 41
      t.text   :metadata
      t.string :ingest_name
      t.string :ingest_hash
      t.timestamps null: false
    end
    add_index :records, :record_hash, :unique => true
    execute "ALTER TABLE `records` 
            CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
            MODIFY metadata longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin;"
  end
end
