require 'uri'
require 'net/http'
require 'json'

class NltkModel
  def self.request(upload_text)
    uri = URI("http://localhost:8080")
    http = Net::HTTP.new(uri.host, 8080)

    req = Net::HTTP::Post.new(uri)
    req["Content-Type"] = "application/json"
    req.body = get_body_request(upload_text)

    res =  http.request(req)
    response_data = JSON.parse(res.body)
    summary = response_data["summary"]
    tags_dict = response_data["tags"]
    category = response_data["category"]
    return { "summary": summary, "tags": tags_dict, "category": category }
  end

  private
  def self.get_body_request(upload_text)
    body_request = {
      "upload": {
        "upload_text": upload_text,
        "replace_dict": {
          "US": "USA", "U.S": "USA", "United States": "USA" },
        "num_tag": "5",
        "summary_threshold": "1.4" }
    }.to_json
    body_request
  end
end
