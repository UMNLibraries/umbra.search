class Flags < ActiveRecord::Migration
  def change
    create_table :flags do |t|
      t.string :on_text
      t.string :off_text
      t.string :on_text_display
      t.string :off_text_display
      t.string :css
      t.integer :search_filter_threshold
      t.boolean :restrict_to_editors
      t.boolean :published
      t.timestamps
    end
  end
end
