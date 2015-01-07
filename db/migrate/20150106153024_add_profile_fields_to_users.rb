class AddProfileFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :twitter_handle, :string
    add_column :users, :biography, :text
  end
end
