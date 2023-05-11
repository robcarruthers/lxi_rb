# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'
Dir.glob('tasks/*.rake').each { |r| import r }

Rake::TestTask.new(:test) do |t|
  t.libs << %w[test spec]
  t.libs << 'lib'
  t.test_files = FileList['test/**/test_*.rb', 'spec/**/*_spec.rb']
end

require 'rubocop/rake_task'

RuboCop::RakeTask.new

task default: %i[test rubocop]
