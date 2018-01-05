class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password
      t.string :salt

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :salt
  end
end
