redis_url = if Rails.env.staging? || Rails.env.production?
  ENV['REDISCLOUD_URL']
else
  "redis://#{ENV.fetch('REDIS_PORT_6379_TCP_ADDR', '127.0.0.1')}:#{ENV.fetch('REDIS_PORT_6379_TCP_PORT', 6379)}"
end
Redis.current = Redis.new(url: redis_url) if redis_url
