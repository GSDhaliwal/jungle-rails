class User < ActiveRecord::Base
  has_secure_password

  validates :password, :length =>{
    :minimum => 3,
    :too_short => "is too short, must be at least 3 characters"
  }, :on => :create

  validates :email, uniqueness: { case_sensitive: false }

  before_save :downcase_fields
  def downcase_fields
    self.email.downcase!
  end
  def self.authenticate_with_credentials (email, password)
    user = User.find_by(email: email.downcase.strip).try(:authenticate, password)
    if user
      return user
    else
      return nil
    end
  end
  
end
