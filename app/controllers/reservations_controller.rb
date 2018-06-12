class ReservationsController < ApplicationController
  before_action :load_user

  def reserve
    reservation_handler.reserve(book)
    redirect_to(book_path(book.id))
  end

  def take
    reservation_handler.take(book)
    redirect_to(book_path(book.id))
  end

  def give_back
    reservation_handler.give_back(book) if book.can_give_back?(current_user)
    redirect_to(book_path(book.id))
  end

  def cancel
    reservation_handler.cancel_reservation(book)
    redirect_to(book_path(book.id))
  end

  private

  def book
    @book ||= Book.find(params[:book_id])
  end

  def reservation_handler
    @reservation_handler ||= ::ReservationsHandler.new(current_user)
  end

  def load_user
    @user = User.find(params[:user_id])
  end
end
