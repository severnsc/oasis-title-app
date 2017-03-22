class Post < ApplicationRecord
  include Bootsy::Container
  belongs_to :user
  validates :title, presence: true, length: {maximum: 255}
  validates :body, presence: true
  validates :user, presence: true
  validates :status, presence: true
end
