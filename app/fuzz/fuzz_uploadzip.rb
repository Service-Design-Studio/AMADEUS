require 'fuzzbert'
require '/mnt/c/Users/ngtro/github-classroom/Service-Design-Studio/final-project-group-5-amadeus/app/models/concerns/upload_zip.rb'

fuzz "summary" do

  deploy do |data|
    begin
      Upload.verify_tag(data, "Tag name")
      Upload.verify_category(data, "category name")
      Upload.verify_summary(data, "summary")
      Upload.save_zip_before_ML(data)
    rescue StandardError
    #fine, we just want to capture crashes
    end
  end

  data "JSON template" do
    t = FuzzBert::Template.new '{ upload: { id: ${id}, name: "${name}" } }'
    t.set(:id, FuzzBert::Generators.cycle(1..10000))
    t.set(:name) { "Fixed text plus two random bytes: #{FuzzBert::Generators.random_fixlen(2).call}" }
    t.generator
  end

  data "random data" do
      FuzzBert::Generators.random
      end
    
  end