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

# Skip asset precompilation during build
# We'll run it during container startup when environment is fully available
RUN mkdir -p tmp/pids

# Expose port
EXPOSE 3000

# Start the server with precompilation at runtime
CMD bin/rails db:migrate && \
    bin/rails assets:precompile && \
    bin/rails server -b 0.0.0.0 