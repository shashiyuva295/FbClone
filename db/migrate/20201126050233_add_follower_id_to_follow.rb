class AddFollowerIdToFollow < ActiveRecord::Migration[6.0]
  def change
  	add_column :follows, :follower_id, :string
  	add_column :follows, :followee_id, :string
  end
end
