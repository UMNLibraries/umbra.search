class AddsOnOffCss < ActiveRecord::Migration
  def change
    add_column :flags, :on_css, :string
    add_column :flags, :off_css, :string
    remove_column :flags, :css, :string
  end
end
