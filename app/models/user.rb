class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  attr_accessible :first_name, :last_name, :role
  has_many :user_books, dependent: :destroy
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :role, presence: true

  def admin?
    role.to_sym == :admin
  end

  def current_issued_books
    current_issued_user_books = user_books.select{ |user_book| user_book.returned_on == nil }
    current_issued_user_books.map do |user_book|
      Book.find(user_book.book_id)
    end
  end

  def all_issued_books
    user_books.map do |user_book|
      Book.find(user_book.book_id)
    end
  end

  def user_book_records(book)
    current_issued_records = user_books.select do |user_book|
      user_book.returned_on.blank?
    end

    current_issued_records.select do|user_book|
      user_book.book_id == book.id
    end
  end

  def full_name
    first_name + ' ' + last_name
  end
end
