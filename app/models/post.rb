class Post < ActiveRecord::Base

	belongs_to :author, class_name: User
	has_many :comments, dependent: :destroy

	validates :title, presence: true
	validates :body, presence: true

	self.per_page = 5
end