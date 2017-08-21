require 'httpclient'

class BooksController < ApplicationController

  @@number = 0

  def create
    file_path = "public/img/image_No.#{@@number}.jpg"
    image_data = Base64.urlsafe_decode64(params[:image_url])
    #book.image_url = image_data
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
      @@number += 1
    end

    File.delete(file_path)

    result_hash = JSON.load(@res.body)
    p result_hash
    result_hash['data']['link']
  end


  private
    def book_params
      params.permit(:name, :price, :purchase_date, :image_url)
    end

end
