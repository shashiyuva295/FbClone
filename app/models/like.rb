class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  acts_as_notifiable :users,
           targets: :custom_notification_users,
           group: :article,
           notifier: :user,
           email_allowed: :custom_notification_email_to_users_allowed?,
           notifiable_path: :custom_notifiable_path
end
