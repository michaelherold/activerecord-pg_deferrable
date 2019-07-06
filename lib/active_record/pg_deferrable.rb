# frozen_string_literal: true

require 'active_record/pg_deferrable/constraints'

module ActiveRecord
  module PgDeferrable
    def transaction_with_deferred_constraints_on(*column_names, **options)
      transaction(options) do
        constraints = Constraints.with(connection).on(table: table_name, columns: column_names)
        connection.execute("SET CONSTRAINTS #{constraints} DEFERRED") if constraints.any?
        yield
      end
    end
  end
end
