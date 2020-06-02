class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)
    email = email.strip
    @user = User.where('lower(email) = ?', email.downcase).first
    if @user.authenticate(password)
      @user
    else
      nil
    end
  end

end
