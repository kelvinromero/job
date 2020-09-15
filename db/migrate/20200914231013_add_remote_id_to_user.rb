class AddRemoteIdToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :remote_id, :integer
  end
end
