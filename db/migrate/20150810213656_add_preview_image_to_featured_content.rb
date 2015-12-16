class AddPreviewImageToFeaturedContent < ActiveRecord::Migration
  def change
    add_column :featured_contents, :preview_image, :string
  end
end
