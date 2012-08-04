class ChangeSubscriptionColumnName < ActiveRecord::Migration
  def up
    rename_column :subscriptions, :creator_id, :user_id
  end

  def down
    rename_column :subscriptions, :user_id, :creator_id
  end
end
