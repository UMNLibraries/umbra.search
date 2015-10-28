class CreateDataProviders < ActiveRecord::Migration
  def change
    create_table :data_providers do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
