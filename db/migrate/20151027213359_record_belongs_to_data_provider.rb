class RecordBelongsToDataProvider < ActiveRecord::Migration
  def change
    add_column :records, :data_provider_id, :integer
    add_index  :records, :data_provider_id
  end
end
