class AddEventToNotifications < ActiveRecord::Migration[6.0]
  def change
    add_column :notifications, :event, :string
  end
end
