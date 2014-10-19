redis_url = Rails.env.staging? || Rails.env.production? ? ENV['REDISCLOUD_URL'] : 'redis://127.0.0.1'
$redis = Redis.new(url: redis_url) if redis_url
