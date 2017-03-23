class User < ApplicationRecord
	before_save :downcase_email
    before_create :create_activation_digest
	attr_accessor :activation_token, :remember_token, :reset_token, :admin_token
	has_secure_password
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  	validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: {minimum: 8}, allow_nil: true
    validates :name, presence: true
    has_many :title_orders
    has_many :posts
    has_many :searches

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

    def send_admin_alert_email(invitee)
        UserMailer.admin_alert(self, invitee).deliver_now
    end

    def send_title_alert_email(title_order)
        UserMailer.title_alert(self, title_order).deliver_now
    end

    def send_activation_email
    	UserMailer.account_activation(self).deliver_now
    end

    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end

    def send_admin_invite_email
        UserMailer.admin_invite(self).deliver_now
    end

    def activate
    	update_columns(activated: true, activated_at: Time.zone.now)
    end

    def remember
        self.remember_token = User.new_token
        self.remember_digest = User.digest(remember_token)
        self.reset_sent_at = Time.zone.now
    end

    def forget
        self.remember_token = nil
        self.remember_digest = nil
    end

    def create_password_reset_digest
        self.reset_token = User.new_token
        update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
    end

    def create_admin_invite_digest
        self.admin_token = User.new_token
        self.admin_digest = User.digest(admin_token)
    end

    def password_reset_expired?
        reset_sent_at < 1.hour.ago
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
