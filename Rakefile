require "bundler/gem_tasks"
require 'rake/testtask'

namespace :test do
  Rake::TestTask.new(:spec) do |t|
    t.pattern = 'test/spec/*_spec.rb'
  end

  Rake::TestTask.new(:all) do |t|
    t.pattern = 'test/**/*.rb'
  end
end
