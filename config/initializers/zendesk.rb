require 'zendesk_api'

client = ZendeskAPI::Client.new do |config|
    config.url = "https://rocketelevators5360.zendesk.com/api/v2"
    config.username = ENV["ZENDESK_USERNAME"]
    config.token = ENV["ZENDESK_API_TOKEN"]
    # config.password = "Mykee@123"

    # Optional:

    # Retry uses middleware to notify the user
    # when hitting the rate limit, sleep automatically,
    # then retry the request.
     config.retry = true

    # Raise error when hitting the rate limit.
    # This is ignored and always set to false when `retry` is enabled.
    # Disabled by default.
    config.raise_error_when_rate_limited = false

    # Logger prints to STDERR by default, to e.g. print to stdout:
    require 'logger'
    config.logger = Logger.new(STDOUT)

end