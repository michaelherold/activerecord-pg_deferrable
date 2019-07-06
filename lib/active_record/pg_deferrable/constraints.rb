module ActiveRecord
  module PgDeferrable
    class Constraints
      include Enumerable

      def self.with(connection)
        new(connection: connection)
      end

      def initialize(connection: nil, table: nil, column_names: [])
        self.connection = connection
        self.table_name = table
        self.column_names = column_names
      end

      def each
        return to_enum(__callee__) unless block_given?

        yield deferrable_constraints.each
      end

      def on(table:, columns:)
        self.table_name = table
        self.column_names |= columns
        self
      end

      def to_s
        deferrable_constraints.join(', ')
      end

      attr_reader :column_names
      attr_reader :connection
      attr_reader :table_name

      private

      attr_writer :column_names
      attr_writer :connection
      attr_writer :table_name

      def deferrable_constraints
        return [] unless table_name && column_names.any?

        connection.select_values(
          usage
            .project(usage[:constraint_name])
            .join(constraint).on(usage[:constraint_name].eq(constraint[:conname]))
            .where(table_constraints)
        )
      end

      def table_constraints
        column_names
          .map(&method(:column_constraint))
          .reduce(:or)
      end

      def column_constraint(column_name)
        constraint[:contype]
          .eq('u')
          .and(constraint[:condeferrable])
          .and(usage[:table_name].eq(table_name))
          .and(usage[:column_name].eq(column_name))
      end

      def usage
        Arel::Table.new('information_schema.constraint_column_usage')
      end

      def constraint
        Arel::Table.new('pg_constraint')
      end
    end
  end
end
