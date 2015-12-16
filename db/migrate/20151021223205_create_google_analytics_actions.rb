class CreateGoogleAnalyticsActions < ActiveRecord::Migration
  def change
    create_table :google_analytics_actions do |t|
      t.string :name
      t.references :google_analytics_category, index: true
      t.timestamps null: false
    end
  end
end
