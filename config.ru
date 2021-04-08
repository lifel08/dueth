# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

run Rails.application
Rails.application.load_server

# possible redirection from heroku to domain?
# # config.ru
# gem 'rack-rewrite', '~> 1.5.0'
# require 'rack/rewrite'
# use Rack::Rewrite do
#   r301 %r{.*}, 'https://dueth.herokuapp.com/$&', :if => Proc.new {|rack_env|
#   rack_env['SERVER_NAME'] != 'dueth.com'
# }
# end
