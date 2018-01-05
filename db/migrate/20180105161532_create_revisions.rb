class CreateRevisions < ActiveRecord::Migration[5.1]
  def change
    create_table :revisions do |t|
      t.jsonb :metadata
      t.references :revisable, polymorphic: true, index: true, null: false
      

      t.timestamps
    end
  end
end
