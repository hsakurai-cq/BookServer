require 'httpclient'

class BooksController < ApplicationController
  include ImageHelper

  before_action :authenticate_user!

  def create
    book = Book.new(book_params)
    book.user_id = @current_user.id
    book.image_url = upload_image(Base64.urlsafe_decode64(params[:image_url]))
    if book.save
      #render json: {status: 200, data: book},status: :ok
      render_json_success(book)
    else
      #render json: {status: 'ERROR', message: 'Book not saved', data: book.errors}, status: :unprocessable_entity
      render_json_failure("Cannot saved book")
    end
  end

  private
    def book_params
      params.permit(:name, :price, :purchase_date, :image_url)
    end

end
