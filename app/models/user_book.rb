class UserBook < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  attr_accessible :user_id, :book_id, :issued_on, :returned_on

  validates :user, presence: true
  validates :book, presence: true
  validates :issued_on, presence: true
  validates_associated :book, on: :create
end
