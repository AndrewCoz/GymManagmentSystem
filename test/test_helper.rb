ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors, with: :threads)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    
    # Fix transaction issues in tests
    setup do
      # Start a transaction at the beginning of each test
      if respond_to?(:use_transactional_tests) && use_transactional_tests
        ActiveRecord::Base.connection.begin_transaction(joinable: false)
      end
    end
    
    teardown do
      # Roll back the transaction at the end of each test
      if respond_to?(:use_transactional_tests) && use_transactional_tests
        # Only roll back if we're in a transaction
        if ActiveRecord::Base.connection.transaction_open?
          ActiveRecord::Base.connection.rollback_transaction
        end
      end
    end
  end
end

# Disable asset processing in tests
class << Rails.application.assets
  def find_asset(*)
    nil
  end
end if Rails.application.assets

# Mock sprockets to avoid file system operations during tests
module Sprockets
  class Base
    def find_asset(*)
      nil
    end
  end
end

# Stub out asset compilation for tests
module ActionView
  module Template::Handlers
    class SassHandler
      def self.call(template, source)
        ""
      end
    end
  end
end
