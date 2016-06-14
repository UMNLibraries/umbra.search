class AddFeaturedContentToggle < ActiveRecord::Migration
  def change
    add_column :featured_contents, :is_news, :boolean
  end
end
