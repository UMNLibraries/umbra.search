class CreateFeaturedBoards < ActiveRecord::Migration
  def change
    create_table :featured_boards do |t|
      t.string :title
      t.string :url

      t.timestamps
    end
  end
end
