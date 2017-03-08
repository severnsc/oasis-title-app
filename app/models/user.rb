class User < ApplicationRecord
	before_save :downcase_email
	has_secure_password
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: {minimum: 8}, allow_nil: true

    private

    def downcase_email
    	email.downcase!
    end
end
