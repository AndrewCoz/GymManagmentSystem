FROM ruby:3.3

# Install PostgreSQL client and development libraries plus SQLite
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y postgresql-client libpq-dev nodejs npm sqlite3 libsqlite3-dev curl && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle config set --local without 'development test' && \
    bundle install --no-cache

# Copy application code
COPY . .

# Fix Windows-specific shebang lines in bin scripts
RUN find bin -type f -exec sed -i 's|#!/usr/bin/env ruby.exe|#!/usr/bin/env ruby|g' {} \;

# Set executable permissions for Rails scripts and entrypoint
RUN chmod +x bin/* entrypoint.sh

# Set Rails environment
ENV RAILS_ENV=production
ENV RAILS_LOG_TO_STDOUT=true
ENV RAILS_SERVE_STATIC_FILES=true
ENV NODE_ENV=production

# Precompile assets at build time if assets are available
# Use a temporary SECRET_KEY_BASE for asset precompilation if not provided
RUN if [ -d app/assets ]; then \
      if [ -z "$SECRET_KEY_BASE" ] && [ -z "$RAILS_MASTER_KEY" ]; then \
        export SECRET_KEY_BASE=$(bundle exec rails secret); \
        echo "Using temporary SECRET_KEY_BASE for asset precompilation"; \
        bundle exec rails assets:precompile; \
      else \
        bundle exec rails assets:precompile; \
      fi; \
    fi

# Create required directories
RUN mkdir -p tmp/pids storage log

# Set appropriate permissions
RUN chmod -R 777 tmp storage log

# Expose port
EXPOSE 3000

# Healthcheck to verify the application is running properly
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
  CMD curl -f http://localhost:3000/up || exit 1

# Start the server with the entrypoint script
CMD ["/app/entrypoint.sh"] 