class ReservationsController < ApplicationController
  before_action :load_user, only: [:users_reservations]

  def reserve
    book.reserve(current_user) if book.can_reserve?(current_user)
    redirect_to(book_path(book.id))
  end

  def take
    book.take(current_user) if book.can_take?(current_user)
    redirect_to(book_path(book.id))
  end

  def give_back
    book.give_back if book.can_give_back?(current_user)
    redirect_to(book_path(book.id))
  end

  def cancel
    book.cancel_reservation(current_user)
    redirect_to(book_path(book.id))
  end

  def users_reservations
  end

  private

  def book
    @book ||= Book.find(params[:book_id])
  end

  def load_user
    @user = User.find(params[:user_id])
  end
end
