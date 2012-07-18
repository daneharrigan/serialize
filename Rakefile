#!/usr/bin/env rake
require "bundler/gem_tasks"

task :default do
  exec "ruby -Itest:lib test/all.rb"
end

task :bench do
  exec "ruby -Itest:lib test/*_benchmark.rb"
end
