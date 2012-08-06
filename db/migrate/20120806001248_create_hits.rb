class CreateHits < ActiveRecord::Migration
  def change
    create_table :hits do |t|
      t.integer :tag_id
      t.integer :requester_id
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
