class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :image_link
      t.string :email, null: false
      t.string :password_digest, null:false
      t.string :first_name, null: false
      t.string :last_name, null:false
      t.date :age
      t.integer :contact
      t.string :gender  
      t.timestamps
    end
  end
end
