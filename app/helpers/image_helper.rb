require 'httpclient'

module ImageHelper

  def upload_image(encoded_image_string)
    @@file_path = "public/img/#{Time.now.to_i.to_s}.jpg"

    store_iamge_to_local(encoded_image_string)
    request_imgur_url
  end

  def store_iamge_to_local(encoded_image_string)
    File.open(@@file_path, 'wb') do |f|
      #binding.pry
      f.write(Base64.urlsafe_decode64(encoded_image_string))
    end
  end

  def request_imgur_url
    http_client = HTTPClient.new
    url = 'https://api.imgur.com/3/image'
    auth_header = { 'Authorization' => 'Client-ID ' + ENV['IMGUR_CLIENT_ID']}

    File.open(@@file_path) do |file|
      body = { 'image' => file }
      @res = http_client.post(URI.parse(url), body, auth_header)
    end

    File.delete(@@file_path)
    result_hash = JSON.load(@res.body)
    #p result_hash
    result_hash['data']['link']
  end
end
