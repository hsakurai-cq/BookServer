require 'httpclient'

class BooksController < ApplicationController
  include ImageHelper
  before_action :authenticate_user!

  @@current_page = 1

  def index
    if page = params[:page].to_i
      #books = Book.where(user_id: @current_user.id).order(:created_at).limit(page.to_i)
      books = @current_user.books.order(:created_at).limit(2).offset((page - 1) * 2)
        render json: {code: 200,
                      # result: BookSerializer.new(books, each_serializer: BookSerializer),
                      result: ActiveModel::Serializer::CollectionSerializer.new(books, each_serializer: BookSerializer),
                      total_count: 2 * page,
                      total_pages: page,
                      current_page: @@current_page,
                      limit: 2 * page,
                    },status: :ok
      @@current_page += 1
    else
      render_json_failure("Wrong Paging")
    end
  end

  def create
    book = Book.new(book_params)
    book.user_id = @current_user.id
    book.image = upload_image(params[:image])
    if book.save
      render_book_action_success(book)
    else
      render_json_failure("Can not save book")
    end
  end

  def update
    book = Book.find(params[:id])
    params[:image] = upload_image(params[:image])
    if book.update_attributes(book_params)
      render_book_action_success(book)
    else
      render_json_failure("Cannot update book")
    end
  end

  private
    def book_params
      params.permit(:name, :price, :purchase_date, :image, :page)
    end
end
