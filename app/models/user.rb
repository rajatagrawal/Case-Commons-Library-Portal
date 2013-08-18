class User< ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email_address

  has_many :books
end
