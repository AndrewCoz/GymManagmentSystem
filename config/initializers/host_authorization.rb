# Disable host authorization in production for Back4App
if Rails.env.production?
  # Option 1: Allow all hosts (recommended for Back4App deployment)
  Rails.application.config.hosts = nil
  
  # Option 2: Use explicit hosts list instead (uncomment if needed)
  # Rails.application.config.hosts ||= []
  # Rails.application.config.hosts << ".b4a.run"
  # Rails.application.config.hosts << ".back4app.io"
  # Rails.application.config.hosts << "gymmanagementdeployment-gllfitc9.b4a.run"
else
  # For development and testing, allow localhost
  Rails.application.config.hosts ||= []
  Rails.application.config.hosts << "localhost"
end 