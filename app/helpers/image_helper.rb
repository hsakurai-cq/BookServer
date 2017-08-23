require 'httpclient'

module ImageHelper

  def upload_image(encoded_image_string)
    time_stamp = Time.now.to_i.to_s
    file_path = "public/img/#{time_stamp}.jpg"
    image_data = Base64.urlsafe_decode64(encoded_image_string)
    File.open(file_path, 'wb') do |f|
      #binding.pry
      f.write(image_data)
    end

    http_client = HTTPClient.new
    url = 'https://api.imgur.com/3/image'
    auth_header = { 'Authorization' => 'Client-ID ' + ENV['IMGUR_CLIENT_ID']}
    File.open(file_path) do |file|
      body = { 'image' => file }
      @res = http_client.post(URI.parse(url), body, auth_header)
    end

    File.delete(file_path)
    result_hash = JSON.load(@res.body)
    #p result_hash
    return result_hash['data']['link']
  end
end
