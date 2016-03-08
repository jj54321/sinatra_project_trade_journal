class User < ActiveRecord::Base
  has_secure_password

  has_many :positions
  has_many :trades, through: :positions

end