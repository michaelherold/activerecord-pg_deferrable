# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'activerecord/pg_deferrable'

def test_root
  Pathname.new(File.expand_path(__dir__))
end

require_relative 'support/connection'
require_relative 'support/database_test'
require_relative 'support/rails_env'

require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::DefaultReporter.new
