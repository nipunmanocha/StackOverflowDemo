class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :text, null: false
      t.integer :commentable_id, null: false
      t.string :commentable_type, null: false
      t.integer :user_id, null: false
      t.timestamp :deleted_at

      t.timestamps
    end
    add_index :comments, [:commentable_id, :commentable_type]
    add_index :comments, :user_id
    add_foreign_key :comments, :users
  end
end
