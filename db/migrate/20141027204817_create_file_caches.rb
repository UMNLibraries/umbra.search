class CreateFileCaches < ActiveRecord::Migration
  def change
    create_table :file_caches do |t|
      t.string :record_id
      t.string :url
      t.boolean :valid_content
      t.string :content_type
      t.string :filepath

      t.timestamps
    end
  end
end
