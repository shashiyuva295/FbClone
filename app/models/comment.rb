class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  has_rich_text :body
  # targets: ->(comment, key) {
  #       ([comment.post.user] + comment.post.users.to_a - [comment.user]).uniq
  #     },
  #     # Path to move when the notification is opened by the target user
  #     # This is an optional configuration since activity_notification uses polymorphic_path as default
  #     tracked: true
  #     notifiable_path: :post_notifiable_path

  #   def post_notifiable_path
  #     post_path(post)
  #   end
  
end
