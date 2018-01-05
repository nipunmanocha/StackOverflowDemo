class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.integer :value, null: false, default: 0
      t.references :voteable, polymorphic: true, index: true, null: false
      t.belongs_to :user, index: true, foreign_key: true, null: false
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
