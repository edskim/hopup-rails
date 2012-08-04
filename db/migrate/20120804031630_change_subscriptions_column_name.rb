class ChangeSubscriptionsColumnName < ActiveRecord::Migration
  def up
    rename_column :topics, :user_id, :creator_id
  end

  def down
    rename_column :topics, :creator_id, :user_id
  end
end
