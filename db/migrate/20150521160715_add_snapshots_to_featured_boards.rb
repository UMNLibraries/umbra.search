class AddSnapshotsToFeaturedBoards < ActiveRecord::Migration
  def change
    add_column :featured_boards, :snapshot, :string
  end
end
