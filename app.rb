require 'sinatra'
require 'em-http-request'
require 'redis'
require 'dotenv'

Dotenv.load
uri = URI.parse(ENV["REDIS_URI"])
redis = Redis.new(:host => uri, :port => 10619, :password => ENV["REDIS_PASS"])
redis.setnx "loadc", "100"

get '/' do
  redis.incr "loadc"
  if (redis.get "loadc").to_i%2 != 0
    redirect 'http://scuteser.herokuapp.com/'
  end
end

get '/blank' do
  erb :master
end

get '/test' do

end

get '/loaderio-db0de517c7188e5b1e035c98a0e33e25/' do
  "loaderio-db0de517c7188e5b1e035c98a0e33e25"
end
