class AddDescriptionToFolderItems < ActiveRecord::Migration
  def change
    add_column :blacklight_folders_folder_items, :description, :text
  end
end
