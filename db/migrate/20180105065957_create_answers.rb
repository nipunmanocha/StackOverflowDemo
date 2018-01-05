class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.string :text, null: false
      t.integer :question_id, null: false
      t.integer :user_id, null: false
      t.boolean :accepted, default: false
      t.timestamp :deleted_at

      t.timestamps
    end
    add_index :answers, :question_id
    add_index :answers, :user_id

    add_foreign_key :answers, :questions
    add_foreign_key :answers, :users
  end
end
