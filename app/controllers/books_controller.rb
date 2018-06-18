class BooksController < ApplicationController
  before_action :load_books, only: :index
  before_action :load_book, only: :show
  before_action :new_book, only: :create
  before_action :reservations_handler, only: :show

  def index
  end

  def new
  end

  def edit
  end

  def create
    if new_book.save
      redirect_to books_path
    else
      redirect_to new_book_path
    end
  end

  def show
  end

  def destroy
  end

  def reservations_handler
    @reservations_handler ||= ReservationsHandler.new(current_user, load_book)
  end

  private

  def load_books
    @books = Book.all
  end

  def load_book
    @book = Book.find(params[:id])
  end

  def new_book
    @book = Book.new(title: params[:title], isbn: params[:isbn], category_name: params[:category_name])
  end
end
