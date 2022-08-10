require 'json'
require 'fuzzbert'

fuzz "JSON.parse" do

  deploy do |data|
    JSON.parse data
  end
  data "completely random" do
    FuzzBert::Generators.random
  end

  data "enclosing curly braces" do
    c = FuzzBert::Container.new
    c << FuzzBert::Generators.fixed("{")
    c << FuzzBert::Generators.random
    c << FuzzBert::Generators.fixed("}")
    c.generator
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