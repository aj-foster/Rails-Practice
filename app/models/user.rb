class User < ActiveRecord::Base

	ROLES = %w[Author Admin]
	before_create :set_default_role

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
			:recoverable, :rememberable, :trackable, :validatable

	has_many :posts, dependent: :destroy, foreign_key: :author_id
	has_many :comments, dependent: :destroy, foreign_key: :author_id

	validates :first_name, presence: true
	validates :last_name, presence: true

	def name (order = :first_last)

		case order
		when :first_last
			first_name + " " + last_name
		when :last_first
			last_name + ", " + first_name
		else
			first_name
		end
	end


	private

		def set_default_role
			self.role = ROLES[0] unless self.role.present?
		end
end