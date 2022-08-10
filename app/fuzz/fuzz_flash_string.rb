require 'fuzzbert'
require '/mnt/c/Users/ngtro/github-classroom/Service-Design-Studio/final-project-group-5-amadeus/app/models/concerns/flash_string.rb'

fuzz "flash string method" do

    deploy do |data|
      begin
      FlashString::TagString.get_added_tag data
      rescue StandardError
      #fine, we just want to capture crashes
      end
    end
  
    data "mutated data" do
      m = FuzzBert::Mutator.new "Testing"
      m.generator
    end
  
    data "fixed curly braces" do
      c = FuzzBert::Container.new
      c << FuzzBert::Generators.fixed("{")
      c << FuzzBert::Generators.random
      c << FuzzBert::Generators.fixed("}")
      c.generator
    end
    data "random data" do
      FuzzBert::Generators.random
    end
  
  end