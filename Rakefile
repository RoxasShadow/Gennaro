#! /usr/bin/env ruby
require 'rake'

task :default => [ :build, :install, :test ]

task :build do
  sh 'gem build *.gemspec'
end

task :install do
  sh 'gem install *.gem'
end

task :test do
  FileUtils.cd 'spec' do
    sh 'rspec gennaro_spec.rb --backtrace --color --format doc'
  end
end