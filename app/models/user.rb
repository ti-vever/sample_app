class User < ActiveRecord::Base
	before_save {self.email = email.downcase}
	validates :name, length: {maximum: 50}, presence: true
	VALIDATE_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, length: {maximum: 255},  presence: true,
				format: {with: VALIDATE_EMAIL_REGEX },
				uniqueness: {case_sensitive: false}
	has_secure_password
	validates :password, length: {minimum: 6}
end