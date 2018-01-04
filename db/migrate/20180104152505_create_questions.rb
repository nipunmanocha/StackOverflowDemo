class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :text
      t.integer :user_id, null: false
      t.integer :duplicate_id
      t.boolean :wiki, default: false

      t.timestamps
    end
    add_index :questions, :user_id
    add_foreign_key :questions, :users
  end
end
