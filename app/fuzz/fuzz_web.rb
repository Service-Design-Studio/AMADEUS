require 'fuzzbert'
require 'uri'
require 'net/http'

fuzz "amadeus page" do

  deploy do |data|
    begin
    @url_string = 'http://localhost:3000/' + data
    uri = URI(@url_string)
      req = Net::HTTP::Get.new(uri)
    rescue URI::InvalidURIError
    end
  end

  data "mutated data" do
    m = FuzzBert::Mutator.new "sign_in"
    m.generator
    end

end