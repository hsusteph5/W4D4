class User < ApplicationRecord
  validates :email, :password_digest, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  validates :session_token, presence: true, uniqueness: true
  after_initialize :ensure_session_token

  #generates the session token string
  def self.generate_session_token
    self.session_token = SecureRandom.urlsafe_base64
  end

  def self.find_by_credentials(email, password)
    #you already passed in the username value, so you only need to look
    #up by the username
    #return a user 
    user = User.find_by(email: email)
    # debugger
    if user && user.is_password?(password)
      user
    else
      nil
    end
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end

  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end

  attr_reader :password

  #resetting the password digest to the encrypted password
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
end
