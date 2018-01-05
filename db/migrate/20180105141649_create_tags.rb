class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :value, null: false, index: true
      t.string :description
      t.timestamp :deleted_at

      t.timestamps
    end

    create_table :questions_tags, id: false do |t|
      t.belongs_to :question, index: true, foreign_key: true, null: false
      t.belongs_to :tag, index: true, foreign_key: true, null: false
    end
  end
end
