class Post < ApplicationRecord

	has_many :likes, dependent: :destroy
	has_rich_text :text
	has_many :comments, dependent: :destroy
	belongs_to :user

end
