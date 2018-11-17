class User < ApplicationRecord
  validates :password_digest, presence: true
  validates :username, presence: true, uniqueness: true
  validates :session_token, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6, allow_nil: true }
  after_initialize :ensure_session_token
  
  attr_reader :password
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    if user && user.is_password?(password)
      return user
    else
      nil
    end
  end
  
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    @password = password
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def generate_session_token 
    self.session_token = SecureRandom::urlsafe_base64(16)
  end 
  
  def ensure_session_token 
    self.session_token ||= self.generate_session_token
  end 
  
  def reset_session_token!
    self.session_token = self.generate_session_token
    self.save 
    self.session_token
  end 
  
end