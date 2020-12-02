class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.references :user, index: true, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.integer :identifier
      t.string :notice_type
      t.boolean :read

      t.timestamps
    end

    add_foreign_key :notifications, :users
    add_foreign_key :notifications, :posts

  end
end
