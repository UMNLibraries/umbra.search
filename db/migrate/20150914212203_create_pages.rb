class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :body
      t.string :link_title
      t.string :link_path

      t.timestamps null: false
    end
  end
end
