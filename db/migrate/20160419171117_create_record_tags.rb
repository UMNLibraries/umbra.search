class CreateRecordTags < ActiveRecord::Migration
  def change
    create_table :record_tags do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :record, index: true
      t.timestamps null: false
    end
  end
end
