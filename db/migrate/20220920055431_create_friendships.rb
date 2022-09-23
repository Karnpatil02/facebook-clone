class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|
      t.references :user, null: false,  foreign_key: true
      t.references :friend, null: false
      t.boolean :status, index: true
      t.timestamps
    end
    add_foreign_key :friendships, :users, column: :friend_id
  end
end
