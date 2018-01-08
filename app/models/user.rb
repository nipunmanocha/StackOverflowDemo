class User < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    before_save { self.email = email.downcase }

    validates :name, presence: true, length: { maximum: 50 }
    validates :email, 
        presence: true, 
        length: { maximum: 255 }, 
        format: { with: VALID_EMAIL_REGEX },
        uniqueness: { case_sensitive: false }

    has_secure_password

    has_many :questions
    has_many :answers
    has_many :votes
    has_many :comments

    default_scope { where(deleted_at: nil) }
end