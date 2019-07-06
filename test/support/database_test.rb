require 'active_support/test_case'
require_relative 'migration_helpers'
require_relative 'table_helpers'

class ActiveRecord::PgDeferrable::DatabaseTest < ActiveSupport::TestCase
  include MigrationHelpers
  include TableHelpers
end
