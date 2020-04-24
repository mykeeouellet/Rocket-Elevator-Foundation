class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, stretches: 13
  # devise :database_authenticatable, :registerable, :recoverable, :confirmable, stretches: 13
  has_one :customer
  
  validate :secure_password

  def secure_password
    pc = password_complexity
    if pc == false
      errors.add :password, "Must include at least one of the following: uppercase, lowercase, digit "
    end
  end

  def password_complexity
    # Must contain lowercase characters
    return false if (password =~ /[a-z]/).nil?
    # Must contain uppercase characters
    return false if (password =~ /[A-Z]/).nil?
    # Must contain digits
    return false if (password =~ /[0-9]/).nil?
    # Password can't be default to password
    return false unless (password.downcase[/password/]).nil?
  end
end

