if Rails.env == 'development' || ENV['ENABLE_RACK_PROFILER'] == 'true'
  require 'rack-mini-profiler'

  # initialization is skipped so trigger it
  Rack::MiniProfilerRails.initialize!(Rails.application)
end
