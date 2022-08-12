require 'fuzzbert'
require '/mnt/c/Users/ngtro/github-classroom/Service-Design-Studio/final-project-group-5-amadeus/app/models/concerns/nltk_model.rb'

fuzz "ntlk request method" do

  deploy do |data|
    begin
    NltkModel.request(data)
    NltkModel.get_body_request(data)
    rescue StandardError
    #fine, we just want to capture crashes
    end
  end

  data "mutated text" do
    m = FuzzBert::Mutator.new "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis elementum convallis arcu sed bibendum. Aenean consectetur rutrum mauris, sed posuere odio faucibus ut. Nulla posuere scelerisque consequat. Mauris vel leo in nisl ullamcorper lobortis nec a libero. Cras finibus justo mi, vel egestas metus rhoncus sed. Proin porttitor accumsan commodo. Curabitur metus urna, tristique quis leo id, accumsan aliquet ligula. Aenean feugiat vel purus nec cursus. Vestibulum sed risus eros. Etiam vitae orci nec elit tincidunt maximus vel non ex. Pellentesque scelerisque magna eu iaculis interdum."
    m.generator
  end

  data "random data" do
    FuzzBert::Generators.random
  end

end