# frozen_string_literal: true

require 'active_record'
require 'rake/testtask'
require 'rubocop/rake_task'
require './lib/db.rb'
RuboCop::RakeTask.new

task default: [:guard]

Rake::TestTask.new do |test|
  test.test_files = Dir['./test/**/*_test.rb']
  test.verbose = true
end

desc 'Run Format'
task :format do
  sh 'rubocop --fix-layout'
end

desc 'Run Guard'
task :guard do
  sh 'guard start'
end

desc 'Show Rubocop Report'
task :linter_report do
  sh 'launchy ./tmp/rubocop_results.html'
end

desc 'Show Coverate Report'
task :coverage_report do
  sh 'launchy ./coverage/index.html'
end

namespace :db do
  DB.connect

  desc 'CreateDatabase'
  task :create do
    DB.create
  end

  desc 'DropDatabase'
  task :drop do
    DB.destroy
  end
end