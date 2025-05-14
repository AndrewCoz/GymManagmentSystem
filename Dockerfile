FROM ruby:3.3

# Install PostgreSQL client and development libraries
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y postgresql-client libpq-dev nodejs npm && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle config set --local without 'development test' && \
    bundle install

# Copy application code
COPY . .

# Set Rails environment
ENV RAILS_ENV=production
ENV RAILS_LOG_TO_STDOUT=true
ENV RAILS_SERVE_STATIC_FILES=true
ENV NODE_ENV=production

# Generate a random secret key base if not provided through environment
RUN if [ -z "$SECRET_KEY_BASE" ] && [ -z "$RAILS_MASTER_KEY" ]; then \
      echo "WARNING: No SECRET_KEY_BASE or RAILS_MASTER_KEY provided. Using a generated one for now."; \
      echo "For production, please set RAILS_MASTER_KEY or SECRET_KEY_BASE in your environment."; \
      export SECRET_KEY_BASE=$(bundle exec rails secret); \
    fi

# Precompile assets at build time if assets are available
RUN if [ -d app/assets ]; then bundle exec rails assets:precompile; fi

# Create required directories
RUN mkdir -p tmp/pids storage log

# Set appropriate permissions
RUN chmod -R 777 tmp storage log

# Expose port
EXPOSE 3000

# Healthcheck to verify the application is running properly
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s --retries=3 \
  CMD curl -f http://localhost:3000/up || exit 1

# Start the server - modified to set a temporary SECRET_KEY_BASE if needed
CMD if [ -z "$SECRET_KEY_BASE" ] && [ -z "$RAILS_MASTER_KEY" ]; then \
      export SECRET_KEY_BASE=$(bundle exec rails secret); \
    fi && \
    bin/rails db:prepare && \
    bin/rails server -b 0.0.0.0 