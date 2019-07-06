# frozen_string_literal: true

require 'test_helper'

class ActiveRecord::PgDeferrableTest < ActiveRecord::PgDeferrable::DatabaseTest
  class TestTable < ActiveRecord::Base
    extend ActiveRecord::PgDeferrable

    self.table_name = 'test_table'
  end

  def setup
    db_tasks.load_schema db_config, :sql, (test_root / 'fixtures' / 'schema.sql').to_s
  end

  def teardown
    connection.execute 'DROP TABLE IF EXISTS test_table'
  end

  def test_reordering_within_a_deferred_transaction
    first = TestTable.create!(ordering: 1)
    second = TestTable.create!(ordering: 2)

    TestTable.transaction_with_deferred_constraints_on(:ordering) do
      first.update_attribute :ordering, 2
      second.update_attribute :ordering, 1
    end
  end

  def test_collisions_within_a_deferred_transaction
    first = TestTable.create!(ordering: 1)
    _second = TestTable.create!(ordering: 2)

    assert_raises(ActiveRecord::RecordNotUnique) do
      TestTable.transaction_with_deferred_constraints_on(:ordering) do
        first.update_attribute :ordering, 2
      end
    end
  end
end
