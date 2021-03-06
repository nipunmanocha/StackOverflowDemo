class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :text, null: false
      t.references :commentable, polymorphic: true, index: true, null: false
      t.belongs_to :user, null: false, index: true, foreign_key: true
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
