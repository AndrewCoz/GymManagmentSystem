# Gym Management System

A comprehensive gym management system built with Ruby on Rails 8.0. This application allows gym administrators to manage members, trainers, and gym classes with a modern and intuitive interface.

## Features

- Dashboard with analytics and key metrics
- Member management (add, edit, view, delete)
- Trainer management (add, edit, view, delete)
- Gym class scheduling and management
- Modern UI with Bootstrap and Bootstrap Icons
- Test-driven development with RSpec
- CI/CD with GitHub Actions and AWS Elastic Beanstalk deployment

## Technology Stack

- Ruby 3.3.0
- Rails 8.0.1
- PostgreSQL (Production)
- SQLite (Development/Test)
- Bootstrap 5.3
- RSpec for testing
- AWS for deployment (S3, EC2, Elastic Beanstalk)
- Chartkick for data visualization

## Setup for Development

1. Clone the repository
   ```
   git clone [repository-url]
   cd gym-management-system
   ```

2. Install dependencies
   ```
   bundle install
   ```

3. Setup database
   ```
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. Start the server
   ```
   rails server
   ```

5. Visit `http://localhost:3000` in your browser

## Testing

Run the test suite:
```
bundle exec rspec
```

## Deployment to AWS

### Prerequisites

1. AWS Account
2. AWS CLI installed and configured
3. AWS Elastic Beanstalk CLI installed

### Steps for Deployment

1. Set up AWS environment variables:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `AWS_REGION`
   - `AWS_BUCKET` (for S3 storage)
   - `RDS_DB_NAME`
   - `RDS_USERNAME`
   - `RDS_PASSWORD`
   - `RDS_HOSTNAME`
   - `RDS_PORT`

2. Deploy using CI/CD:
   - Push to the main branch and GitHub Actions will handle the deployment
   - Or manually deploy using:
     ```
     eb deploy
     ```

### Manual Setup in AWS (One-time)

1. Create an RDS PostgreSQL instance
2. Create an S3 bucket for file storage
3. Create an Elastic Beanstalk application
4. Configure security groups and IAM roles

## License

This project is licensed under the MIT License.
