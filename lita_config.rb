require './custom/bot'

Lita.configure do |config|
  # The name your robot will use.
  config.robot.name = "Lita"

  # The locale code for the language to use.
  # config.robot.locale = :en

  # The severity of messages to log. Options are:
  # :debug, :info, :warn, :error, :fatal
  # Messages at the selected level and above will be logged.
  config.robot.log_level = :info

  # An array of user IDs that are considered administrators. These users
  # the ability to add and remove other users from authorization groups.
  # What is considered a user ID will change depending on which adapter you use.
  # config.robot.admins = ["1", "2"]

  # The adapter you want to connect with. Make sure you've added the
  # appropriate gem to the Gemfile.
  #config.robot.adapter = :shell

  ## Example: Set options for the chosen adapter.
  # config.adapter.username = "myname"
  # config.adapter.password = "secret"

  config.robot.adapter = :slack

  if ENV["RACK_ENV"].nil?
    require 'yaml'
    secrets = YAML.load_file('secrets.yml')
    ## Example: Set options for the Redis connection.
    config.redis.host = secrets.inspect['development']['redis_host']
    config.redis.port = secrets.inspect['development']['redis_port']
    # https://www.wunderground.com
    config.handlers.weather.api_key = secrets.inspect['development']['weather_underground_api_key']
  else
    config.adapters.slack.token = ENV["SLACK_TOKEN"]
    # Heroku
    config.redis[:url] = ENV["REDISTOGO_URL"]
    config.http.port = ENV["PORT"]
    # https://www.wunderground.com
    config.handlers.weather.api_key = ENV["WEATHER_UNDERGROUND_API_KEY"]
  end

  ## Example: Set configuration for any loaded handlers. See the handler's
  ## documentation for options.
  # config.handlers.some_handler.some_config_key = "value"

  config.adapters.shell.private_chat = true

end
