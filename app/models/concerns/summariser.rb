require 'uri'
require 'net/http'
require 'json'

class Summariser
  FLASK_URL = ENV.fetch('FLASK_URL', nil)
  @uri_string = FLASK_URL+'/summariser'
  def self.request(upload_text)
    uri = URI(@uri_string)
    req = Net::HTTP::Post.new(uri)
    req["Content-Type"] = "application/json"
    req.body = get_body_request(upload_text)
    http = Net::HTTP.new(uri.host, uri.port)
    http.read_timeout=180
    # http.use_ssl = true

    # start local
    # uri = URI("http://localhost:5001")
    # http = Net::HTTP.new(uri.host, 5001)
    # http.read_timeout=180
    # end local

    res = http.request(req)
    response_data = JSON.parse(res.body)
    summary = response_data["data"]["summary"]
    return { "summary": summary }
  end

  private

  def self.get_body_request(upload_text)
    body_request = {
      "inputs": upload_text
    }.to_json
    body_request
  end
end
