require 'fuzzbert'
require '/mnt/c/Users/ngtro/github-classroom/Service-Design-Studio/final-project-group-5-amadeus/app/models/upload.rb'

fuzz "tag" do
    
    deploy do |data|
      begin
        Upload.verify_tag(data, "Testing")
      rescue StandardError
      #fine, we just want to capture crashes
      end
    end

    data "mutated data" do
        m = FuzzBert::Mutator.new "Testing"
        m.generator
        end
    data "enclosing curly braces" do
        c = FuzzBert::Container.new
        c << FuzzBert::Generators.fixed("Testing")
        # c << FuzzBert::Generators.fixed("}")
        c.generator
        end
    data "random data" do
        FuzzBert::Generators.random
        end
    end