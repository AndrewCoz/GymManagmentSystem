# Explicitly require solid components in development
unless Rails.env.production?
  begin
    require "solid_queue"
    require "solid_queue/record"
    require "solid_cache"
    require "solid_cable"
  rescue LoadError => e
    puts "Warning: Unable to load a solid component: #{e.message}"
  end
end 