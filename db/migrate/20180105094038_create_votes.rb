class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.integer :value, null: false, default: 0
      t.integer :voteable_id, null: false
      t.string :voteable_type, null: false
      t.integer :user_id, null: false
      t.timestamp :deleted_at

      t.timestamps
    end

    add_index :votes, [:voteable_id, :voteable_type]
  end
end
