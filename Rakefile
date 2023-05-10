# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'
Dir.glob('lib/tasks/*.rake').each { |r| import r }

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/test_*.rb']
end

require 'rubocop/rake_task'

RuboCop::RakeTask.new

task default: %i[test rubocop]
