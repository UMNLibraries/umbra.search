class CreateFeaturedImages < ActiveRecord::Migration
  def change
    create_table :featured_images do |t|
      t.string :title
      t.string :record_id
      t.string :uploaded_image
      t.boolean :published

      t.timestamps
    end
  end
end
