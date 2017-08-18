class BooksController < ApplicationController

  def create
    book = Book.new(book_params)
    book.purchase_date = DateTime.parse(params[:purchase_date])
    if book.save
      render json: {status: 200, result: book},status: :ok
    else
      render json: {status: 'ERROR', message: 'Book not saved', data: book.errors}, status: :unprocessable_entity
    end
  end


  private
    def book_params
      params.permit(:name, :price, :purchase_date, :image_url)
    end

end
