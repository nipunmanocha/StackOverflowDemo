class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.string :text, null: false
      t.belongs_to :question, null: false, index: true, foreign_key: true
      t.belongs_to :user, null: false, index: true, foreign_key: true
      t.boolean :accepted, default: false
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
