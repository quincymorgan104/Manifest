class User< ActiveRecord::Base
  has_many :mfsts
  has_many :likes
  
    include BCrypt
  
  validates :email, uniqueness: true
  
  def password
    @password = Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end