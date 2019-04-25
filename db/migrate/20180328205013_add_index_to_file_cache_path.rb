class AddIndexToFileCachePath < ActiveRecord::Migration
  def change
    add_index :file_caches, :filepath
  end
end
