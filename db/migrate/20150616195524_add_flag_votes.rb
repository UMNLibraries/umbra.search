class AddFlagVotes < ActiveRecord::Migration
  def change
    create_table :flag_votes do |t|
      t.belongs_to :user
      t.belongs_to :flag
      # Allows us to weight flag editor votes more heavily
      t.integer :weight
      t.string :record_id, limit: 40
      t.timestamps
    end
    add_index :flag_votes, [:user_id, :flag_id, :record_id], :unique => true
  end
end
