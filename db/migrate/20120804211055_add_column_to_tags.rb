class AddColumnToTags < ActiveRecord::Migration
  def change
    add_column :tags, :location, :string
  end
end
