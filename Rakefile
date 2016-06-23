require 'bundler/gem_tasks'
require 'rubocop'
require 'rubocop/rake_task'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.ruby_opts = ['-r./test/test_helper.rb']
end

RuboCop::RakeTask.new(:rubocop) do |task|
  task.fail_on_error = true
end

task default: [:test, :rubocop]
