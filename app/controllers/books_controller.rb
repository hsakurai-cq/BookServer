require 'httpclient'

class BooksController < ApplicationController

  def create
    time_stamp = Time.now.to_i.to_s
    file_path = "public/img/#{time_stamp}.jpg"
    image_data = Base64.urlsafe_decode64(params[:image_url])
    File.open(file_path, 'wb') do |f|
      #binding.pry
      f.write(image_data)
    end
    http_client = HTTPClient.new
    url = 'https://api.imgur.com/3/image'
    auth_header = { 'Authorization' => 'Client-ID d285f83097c5323'}
    File.open(file_path) do |file|
      body = { 'image' => file }
      @res = http_client.post(URI.parse(url), body, auth_header)
    end
    File.delete(file_path)
    result_hash = JSON.load(@res.body)
    p result_hash
    puts result_hash['data']['link']

    book = Book.new(book_params)
    book.image_url = result_hash['data']['link']
    if book.save
      render json: {status: 200, data: book},status: :ok
    else
      render json: {status: 'ERROR', message: 'Book not saved', data: book.errors}, status: :unprocessable_entity
    end
  end

  private
    def book_params
      params.permit(:name, :price, :purchase_date, :image_url)
    end

end
