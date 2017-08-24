require 'httpclient'

class BooksController < ApplicationController
  include ImageHelper
  before_action :authenticate_user!
  before_action :change_image_to_url

  @@current_page = 1
  LIMIT_NUMBER = 2

  def index
    if page = params[:page]
      page_int = page.to_i
      books = @current_user.books.order(:created_at).limit(LIMIT_NUMBER).offset((page_int - 1) * 2)
        render json: {code: 200,
                      # result: BookSerializer.new(books, each_serializer: BookSerializer),
                      result: ActiveModel::Serializer::CollectionSerializer.new(books, each_serializer: BookSerializer),
                      total_count: 2 * page_int,
                      total_pages: page_int,
                      current_page: @@current_page,
                      limit: 2 * page_int,
                    },status: :ok
      @@current_page += 1
    else
      render_json_failure("Wrong Paging")
    end
  end

  def create
    book = @current_user.books.build(book_params)
    if book.save
      render_book_action_success(book)
    else
      render_json_failure("Can not save book")
    end
  end

  def update
    book = Book.find(params[:id])
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

    def change_image_to_url
      params[:image] = upload_image(params[:image])
    end
end
