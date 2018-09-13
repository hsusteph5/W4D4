class User < ApplicationRecord
  validates :emails, presence: true
  validates :password
  after_initialize :ensure_session_token

  #generates the session token string
  def self.generate_session_token
    self.session_token = SecureRandom.urlsafe_base64
  end

  def self.reset_session_token!

  end

  def self.ensure_session_token
    
  end

  attr_reader :password

  #resetting the password digest to the encrypted password
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def user_params
    :user.require(:username, :password)
  end
end
