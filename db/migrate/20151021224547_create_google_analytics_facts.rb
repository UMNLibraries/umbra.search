class CreateGoogleAnalyticsFacts < ActiveRecord::Migration
  def change
    create_table :google_analytics_facts do |t|
      t.integer :count
      t.integer :date
      t.references :google_analytics_action, :index => true
      t.references :record, :index => true
      t.references :location, :index => true
      t.timestamps null: false
    end
    add_index :google_analytics_facts, [:count, :date, :google_analytics_action_id, :record_id, :location_id], unique: true, name: 'google_analytics_facts'
  end
end
