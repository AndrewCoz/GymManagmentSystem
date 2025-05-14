# Deploying to Back4App

This document provides step-by-step instructions for deploying this Rails application to Back4App Containers.

## Prerequisites

1. A Back4App account - [Sign up here](https://www.back4app.com/)
2. GitHub repository with your Rails application
3. Your Rails master key (from config/master.key)

## Deployment Steps

### 1. Push Your Code to GitHub

Make sure your application code is pushed to GitHub, including the Dockerfile and all the changes made for deployment.

### 2. Create a New Container App on Back4App

1. Log in to your Back4App account
2. Click on "New App" in the dashboard
3. Select "Containers as a Service"
4. Click "Edit GitHub Permissions" and select your repository
5. Configure your application:
   - App Name: Your preferred name
   - Git Branch: main (or your preferred branch)
   - Directory: / (or the directory containing your Dockerfile)
6. Click "Create App"

### 3. Configure Environment Variables

Go to the "Settings" tab in your Back4App container app and add the following environment variables:

- `RAILS_MASTER_KEY`: Your Rails master key (from config/master.key)
- `RAILS_ENV`: production
- `RAILS_SERVE_STATIC_FILES`: true
- `RAILS_LOG_TO_STDOUT`: true
- `DATABASE_URL`: If you're using Back4App's database service or an external database

See the `back4app.env.example` file for a complete list of possible environment variables.

### 4. Deploy Your Application

1. Go to "Container Actions" dropdown
2. Select "Deploy the latest Commit"
3. Wait for the deployment to complete
4. Click on the generated app URL to verify your application is running

### 5. Set Up a Custom Domain (Optional)

1. Go to "Settings" > "Domains"
2. Add your custom domain
3. Configure DNS settings as instructed by Back4App

## Troubleshooting

### Application showing "Application not found" or "We're sorry, but something went wrong"

- Check the application logs for errors
- Verify that all required environment variables are set
- Make sure the database migration ran successfully

### Database Connection Issues

- Check if you've set the correct database environment variables
- Verify that your database is accessible from Back4App

### Asset Compilation Errors

- Check if the assets are precompiled correctly
- Verify that all necessary JavaScript and CSS dependencies are included

## Useful Commands

To view logs:
- Go to the "Logs" tab in your Back4App container app

To redeploy after code changes:
1. Push changes to GitHub
2. Go to "Container Actions" > "Deploy the latest Commit" in Back4App

## Getting Support

If you encounter any issues with your Back4App deployment, you can:
- Check the [Back4App documentation](https://www.back4app.com/docs)
- Contact Back4App support 