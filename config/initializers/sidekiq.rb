redis = { url: ENV.fetch('REDIS_URL', "redis://localhost:6379/1"), id: nil }
Sidekiq.configure_server do |config|
  config.redis = redis
  # config.logger = nil
end
Sidekiq.configure_client do |config|
  config.redis = redis
end
