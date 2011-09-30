require 'rake/clean'
require 'rspec/core/rake_task'

CLEAN	=	Rake::FileList["**/*~", "**/*.bak", "**/core", './coverage']

RSpec::Core::RakeTask.new(:spec) do |t| 
  t.pattern = 'test/**/*_spec.rb'
  t.rcov = true
end

task :default => :spec
