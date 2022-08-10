require 'rake'
require 'fuzzbert/rake_task'

FuzzBert::RakeTask.new(:fuzz) do |spec|
  spec.fuzzbert_opts = ['--limit 100', '--console']
  spec.pattern = 'fuzz/**/fuzz_*.rb'
end