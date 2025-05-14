#!/bin/bash
set -e

# Set SECRET_KEY_BASE if not provided
if [ -z "$SECRET_KEY_BASE" ] && [ -z "$RAILS_MASTER_KEY" ]; then
  export SECRET_KEY_BASE=$(bundle exec rails secret)
  echo "WARNING: Using temporary SECRET_KEY_BASE. For production, set RAILS_MASTER_KEY or SECRET_KEY_BASE."
fi

# Print basic debugging info
echo "Ruby version: $(ruby -v)"
echo "Rails version: $(bin/rails -v)"
echo "Environment: $RAILS_ENV"

# Create required directories
mkdir -p tmp/pids storage log

# Disable features that might cause startup issues
export SOLID_QUEUE_ENABLED=false
export RAILS_CACHE_STORE=null_store

# Skip active record entirely if needed
# Uncomment this if database issues persist
#export RAILS_SKIP_ACTIVE_RECORD=true

echo "Starting Rails server..."
# Use exec so the Rails process gets signals directly
exec bin/rails server -b 0.0.0.0 -p 3000 -e production 