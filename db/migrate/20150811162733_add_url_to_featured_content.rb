class AddUrlToFeaturedContent < ActiveRecord::Migration
  def change
    add_column :featured_contents, :url, :string
  end
end
