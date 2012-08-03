class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.float :lat
      t.float :lng
      t.string :text
      t.integer :topic_id

      t.timestamps
    end
  end
end
