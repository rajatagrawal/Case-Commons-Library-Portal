class Book < ActiveRecord::Base

  attr_accessible :title, :author, :publisher, :price, :quantity
  belongs_to :user

  validates :title, presence: true
  validates :author, presence: true
  validates :publisher, presence: true
  validates :price, presence: true

  def checked_out?
    !user.nil?
  end
end
