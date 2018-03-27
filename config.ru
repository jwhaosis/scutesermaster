require './app'
run Sinatra::Application
configure { set :server, :puma }
