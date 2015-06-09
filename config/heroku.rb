if ENV['HEROKU_APP_NAME'].present? and ENV['HEROKU_PARENT_APP_NAME'].present?
  ENV['HEROKU_HOST'] = "#{ ENV['HEROKU_APP_NAME'] }.herokuapp.com"
end
