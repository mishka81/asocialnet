# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#

class User < ActiveRecord::Base
  # attributes accessible to outside code (read/write)
  attr_accessible :name, :email, :password, :password_confirmation

  # Rails (trivial) secure authentication feature : provides a method
  # to authenticate a user with a given password and assures
  # a crypted version is stored in the database.
  has_secure_password
  
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  
  has_many :reverse_relationships, foreign_key: "followed_id",
                                   class_name:  "Relationship",
                                   dependent:   :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  
  # create a user cookie before storing it in the database
  before_save :create_remember_token

  # name attribute validation : not blank
  validates :name, presence: true, length: { maximum: 50 }

  # email attribute validation : not blank, unique, 50 chars max
  # and conform to standard email addresses synthax
  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: valid_email_regex },
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 50 }

  # password validation : 6 chars minimum, and at least a number and
  # a special character
  validates :password, length: { minimum: 6, maximum: 12 }

  def to_s
    "[#{@id}] #{@name} <#{@email}>"
  end
  
  def feed
    Micropost.from_users_followed_by(self)
  end
  
  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end
  
  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end
  
  private
  
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
  
end
