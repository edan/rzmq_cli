require "bundler/gem_tasks"

if ['development', 'test', nil].include?(ENV['RACK_ENV'])
  namespace 'test' do
    require 'rake/testtask'
    Rake::TestTask.new do |t|
      t.libs << "test"
      t.name = 'minitest'
      t.test_files = FileList['test/**/*_test.rb']
      t.verbose = true
    end
  end
  task 'test' => %w(test:minitest)

  task 'default' => 'test'
end
