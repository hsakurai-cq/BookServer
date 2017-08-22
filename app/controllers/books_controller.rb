require 'httpclient'

class BooksController < ApplicationController
  include ImageHelper
  before_action :authenticate_user!

  def index
    if page = params[:page]
      #books = Book.where(user_id: @current_user.id).order(:created_at).limit(page.to_i)
      books = @current_user.books.order(:created_at).limit(page.to_i)
      render_json_success(books)
    else
      render_json_failure("Wrong Paging")
    end
  end

  def create
    book = Book.new(book_params)
    book.user_id = @current_user.id
    book.image_url = upload_image(Base64.urlsafe_decode64(params[:image_url]))
    if book.save
      render_json_success(book)
    else
      render_json_failure("Cannot saved book")
    end
  end

  def update
    book = Book.find(params[:id])
    params[:image_url] = upload_image(Base64.urlsafe_decode64(params[:image_url]))
    if book.update_attributes(book_params)
      render_json_success(book)
    else
      render_json_failure("Cannot update book")
    end
  end

  private
    def book_params
      params.permit(:name, :price, :purchase_date, :image_url)
    end

end
