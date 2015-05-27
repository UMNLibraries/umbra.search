class AddPublishedToFeaturedBoards < ActiveRecord::Migration
  def change
    add_column(:featured_boards, :published, :boolean)
  end
end
