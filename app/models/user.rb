class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
			:recoverable, :rememberable, :trackable, :validatable

	has_many :posts
	has_many :comments

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
end