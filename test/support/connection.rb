# frozen_string_literal: true

require 'active_record'
require 'active_support/hash_with_indifferent_access'

def db_config
  ActiveSupport::HashWithIndifferentAccess.new(
    adapter: 'postgresql',
    database: ENV.fetch('TEST_DATABASE', 'pg_deferrable_test'),
    username: ENV.fetch('TEST_USER') { ENV.fetch('USER', 'pg_deferrable') },
    password: ENV['TEST_PASSWORD']
  )
end

ActiveRecord::Base.establish_connection(db_config)
