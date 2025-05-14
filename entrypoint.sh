#!/bin/bash
set -e

# Set SECRET_KEY_BASE if not provided
if [ -z "$SECRET_KEY_BASE" ] && [ -z "$RAILS_MASTER_KEY" ]; then
  export SECRET_KEY_BASE=$(bundle exec rails secret)
  echo "WARNING: Using temporary SECRET_KEY_BASE. For production, set RAILS_MASTER_KEY or SECRET_KEY_BASE."
fi

# Print Rails and Ruby versions for debugging
echo "Ruby version: $(ruby -v)"
echo "Rails version: $(bin/rails -v)"
echo "Environment: $RAILS_ENV"

# Create directories if they don't exist
mkdir -p tmp/pids storage log

# Print database configurations
echo "Available database configurations:"
bin/rails runner "puts ActiveRecord::Base.configurations.configs_for.map(&:name)"

# Print environment variables for debugging (redact sensitive values)
echo "Environment variables:"
env | grep -v "_KEY\\|PASSWORD\\|SECRET" | sort

# Disable background job processing for initial startup to avoid queue db issues
export SOLID_QUEUE_ENABLED=false

echo "Running database migrations..."
# Run migrations with error handling
if ! bin/rails db:prepare; then
  echo "Error during database migration. Falling back to SQLite if necessary."
  # Explicitly check if we can connect to the database
  bin/rails runner "puts 'Testing default database connection:'; ActiveRecord::Base.connection.execute('SELECT 1'); puts 'Connection successful'" || exit 1
fi

echo "Starting Rails server..."
# Use exec so the Rails process gets signals directly
exec bin/rails server -b 0.0.0.0 -p 3000 -e production 