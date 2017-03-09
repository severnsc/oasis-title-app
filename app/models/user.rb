class User < ApplicationRecord
	before_save :downcase_email
    before_create :create_activation_digest
	attr_accessor :activation_token, :remember_token
	has_secure_password
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: {minimum: 8}, allow_nil: true
    validates :name, presence: true

    def User.new_token
    	SecureRandom.urlsafe_base64
    end

    def User.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
													  BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
    end

    def authenticated?(attribute, token)
    	digest = send("#{attribute}_digest")
    	return false if digest.nil?
    	BCrypt::Password.new(digest).is_password?(token)
    end

    def send_activation_email
    	UserMailer.account_activation(self).deliver_now
    end

    def activate
    	update_columns(activated: true, activated_at: Time.zone.now)
    end

    def remember
        self.remember_token = User.new_token
        self.remember_digest = User.digest(remember_token)
    end

    def forget
        self.remember_token = nil
        self.remember_digest = nil
    end

    private

    def downcase_email
    	email.downcase!
    end

    def create_activation_digest
    	self.activation_token = User.new_token
    	self.activation_digest = User.digest(activation_token)
    end
end
