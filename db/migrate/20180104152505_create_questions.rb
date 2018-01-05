class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :text, null: false
      t.belongs_to :user, null: false, index: true, foreign_key: true
      t.integer :duplicate_id
      t.boolean :wiki, default: false
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
