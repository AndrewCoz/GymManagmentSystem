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

# Start the server
CMD bin/rails db:prepare && \
    bin/rails server -b 0.0.0.0 