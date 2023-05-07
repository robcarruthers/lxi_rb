# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'
require 'structured_changelog/tasks'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/test_*.rb']
end

require 'rubocop/rake_task'

RuboCop::RakeTask.new

task default: %i[test rubocop]
