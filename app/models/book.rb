class Book < ActiveRecord::Base

  attr_accessible :title, :author, :publisher, :price, :quantity
  has_many :user_books

  validates :title, presence: true
  validates :author, presence: true
  validates :publisher, presence: true
  validates :price, presence: true

  def current_users
    current_user_books = user_books.select do |user_book|
      user_book.returned_on == nil
    end
    current_user_books.map do |user_book|
      User.find(user_book.user_id)
    end
  end

  def all_users
    user_books.map do |user_book|
      User.find(user_book.user_id)
    end
  end

  def checked_out?
    if current_users != []
      true
    else
      false
    end
  end

  def can_be_checked_out?
    if number_of_issued_copies < quantity
      true
    else
      false
    end
  end

  def number_of_issued_copies
    current_users.size
  end

  def user_book_records(user)
    current_issued_records = user_books.select do |user_book|
      user_book.returned_on.blank?
    end

    current_issued_records.select do|user_book|
      user_book.book_id == user.id
    end
  end
end
