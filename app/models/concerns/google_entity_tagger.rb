require 'uri'
require 'net/http'
require 'json'

class GoogleEntityTagger
  STOP_WORDS = %w( BBC Register )
  ENTITY = %w( PERSON LOCATION ORGANIZATION EVENT WORK_OF_ART CONSUMER_GOOD )
  API_KEY = ENV['API_KEY']
  @uri_string = 'https://language.googleapis.com/v1/documents:analyzeEntities?key='+API_KEY

  def self.request(upload_text)
    uri = URI(@uri_string)
    req = Net::HTTP::Post.new(uri)
    req["Content-Type"] = "application/json"
    req.body = get_body_request(upload_text)
    http = Net::HTTP.new(uri.host, uri.port)
    http.read_timeout=180
    http.use_ssl = true

    res =  http.request(req)
    response_data = JSON.parse(res.body)
    entities = response_data["entities"]
    entities = get_top_entities(entities, 3, 3, 0.004)
    return { "entities": entities }
  end

  private
  def self.get_body_request(upload_text)
    body_request = {
      "document": {
        "type": "PLAIN_TEXT",
        "content": upload_text
      },
      "encodingType": "UTF8"
    }.to_json
    body_request
  end

  def self.get_top_entities(entities, max_entity, max_other, salience_threshold)
    top_entities = {}
    entity_count = 0
    other_count = 0
    entities.each do |entity|
      if entity_count >= max_entity and other_count >= max_other
        break
      end
      unless STOP_WORDS.include?(entity["name"]) or entity["salience"] < salience_threshold
        if entity["type"] == "OTHER" and other_count < max_other
          other_count += 1
          top_entities.store(entity["name"], entity["type"])
        elsif ENTITY.include?(entity["type"]) and entity_count < max_entity
          entity_count += 1
          top_entities.store(entity["name"], entity["type"])
        end
      end
    end
    top_entities
  end
end
