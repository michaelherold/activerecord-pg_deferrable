require 'active_record'

module TableHelpers
  def connection
    ActiveRecord::Base.connection
  end
end
