class GoogleBooksController < ApplicationController
  def show
    render json: volume_info.to_json
  end

  private

  def volume_info
    total_items.to_i > 0 ? items[0].fetch('volumeInfo', '') : {}
  end

  def items
    google_books_api_response['items']
  end

  def total_items
    book_info_hash_data['totalItems']
  end

  def book_info_hash_data
    google_books_api_response.to_hash
  end

  def google_books_api_response
    HTTParty.get("https://www.googleapis.com/books/v1/volumes?q=isbn:#{params[:isbn]}")
  end
end
