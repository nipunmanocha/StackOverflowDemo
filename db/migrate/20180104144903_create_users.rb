class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, null: false, length: 100
      t.string :email, null: false, length: 100
      t.string :password, null: false
      t.string :salt, null: false

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :salt, unique: true
  end
end
