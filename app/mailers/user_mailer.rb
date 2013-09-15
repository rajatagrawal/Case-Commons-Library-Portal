class UserMailer < ActionMailer::Base
  default from: 'notifications@library.casecommons.org'

  def checkout(user,book)
    @user = user
    @book = book
    binding.pry
    mail(to: [@user.email, User.where(role: :admin).pluck(:email)].flatten, subject: 'Book Checkout Confirmation')

  end
end
