class Post < ApplicationRecord
	has_many :likes, dependent: :destroy
	has_rich_text :content
	has_many :comments, dependent: :destroy
end
