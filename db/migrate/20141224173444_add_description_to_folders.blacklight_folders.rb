# This migration comes from blacklight_folders (originally 20141222223103)
class AddDescriptionToFolders < ActiveRecord::Migration
  def change
     add_column :blacklight_folders_folders, :description, :text
  end
end
