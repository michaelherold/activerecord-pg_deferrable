# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'
require 'appraisal'

task :connection do
  require 'active_record'

  ActiveRecord::Base.establish_connection(
    adapter: 'postgresql',
    username: ENV.fetch('TEST_USER') { ENV.fetch('USER', 'pg_deferrable') },
    password: ENV['TEST_PASSWORD']
  )
end

namespace :test do
  Rake::TestTask.new(:run) do |t|
    t.libs << 'test'
    t.libs << 'lib'
    t.test_files = FileList['test/**/*_test.rb']
  end

  desc 'Create the test database'
  task setup: [:connection] do
    ActiveRecord::Base.connection_pool.with_connection do |conn|
      begin
        conn.create_database(
          ENV.fetch('TEST_DATABASE', 'pg_deferrable_test'),
          owner: ENV.fetch('TEST_USER') { ENV.fetch('USER', 'pg_deferrable') }
        )
      rescue ActiveRecord::StatementInvalid => ex
        raise ex unless ex.cause.is_a?(PG::DuplicateDatabase)
      end
    end
  end

  desc 'Discard the test database'
  task teardown: [:connection] do
    ActiveRecord::Base.connection_pool.with_connection do |conn|
      conn.drop_database ENV.fetch('TEST_DATABASE', 'pg_deferrable_test')
    end
  end
end

task test: %w[test:setup test:run test:teardown]

if !ENV['APPRAISAL_INITIALIZED'] && !ENV['CI']
  task default: :appraisal
else
  task default: :test
end
