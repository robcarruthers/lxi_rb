# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/test_*.rb']
end

require 'rubocop/rake_task'

RuboCop::RakeTask.new

task default: %i[test rubocop]

desc "Bumps the gem version and generates changelog modifications with cocogitto"
task :bump_gem do
  cog_version = `cog -V`
  puts $?
  puts cog_version
end
