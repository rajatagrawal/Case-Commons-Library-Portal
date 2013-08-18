class Book < ActiveRecord::Base

  attr_accessible :title, :author, :publisher, :price
  belongs_to :user
end
