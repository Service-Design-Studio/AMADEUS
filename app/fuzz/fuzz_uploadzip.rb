require 'fuzzbert'
require '/mnt/c/Users/ngtro/github-classroom/Service-Design-Studio/final-project-group-5-amadeus/app/models/concerns/upload_zip.rb'

fuzz "summary" do

    deploy do |data|
      begin
        Upload.verify_summary(data, "Testing")
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

    data "my custom generator" do
      prng = Random.new
      lambda do
        buf = '{ user: { '
        buf << prng.bytes(100)
        buf << ' } }'
        end
      end
      
    end