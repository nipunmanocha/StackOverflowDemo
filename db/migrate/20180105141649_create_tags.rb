class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :value, null: false
      t.string :description
      t.timestamp :deleted_at

      t.timestamps
    end
    add_index :tags, :value

    create_table :questions_tags, id: false do |t|
      t.belongs_to :question, index: true, null: false
      t.belongs_to :tag, index: true, null: false
    end
    add_foreign_key :questions_tags, :questions
    add_foreign_key :questions_tags, :tags
  end
end
