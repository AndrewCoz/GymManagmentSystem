# Temporarily disable SolidQueue and SolidCache to get the app deployed
if Rails.env.production?
  Rails.application.config.active_job.queue_adapter = :async
  
  # Disable SolidQueue
  Rails.application.config.solid_queue.enabled = false if defined?(Rails.application.config.solid_queue)
  
  # Disable SolidCache
  Rails.application.config.solid_cache.enabled = false if defined?(Rails.application.config.solid_cache)
  
  # Disable SolidCable if defined
  Rails.application.config.action_cable.use_solid_cable = false if defined?(Rails.application.config.action_cable)
end 