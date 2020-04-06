class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, stretches: 13
  # devise :database_authenticatable, :registerable, :recoverable, :confirmable, stretches: 13
  has_one :customer
end

