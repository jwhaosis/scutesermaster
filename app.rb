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
  target = (redis.get "loadc").to_i%5
  if target == 0
    redirect 'http://scuteser.herokuapp.com/'
  elsif target == 1
    redirect 'http://scuteser-2.herokuapp.com/'
  elsif target == 2
    redirect 'http://scuteser-3.herokuapp.com/'
  elsif target == 3
    redirect 'http://scuteser-4.herokuapp.com/'
  end
end

get '/loaderio-87117f3cc6f3476f7ec8e1f03770d4f8/' do
  "loaderio-87117f3cc6f3476f7ec8e1f03770d4f8"
end

get '/loaderio-db0de517c7188e5b1e035c98a0e33e25/' do
  "loaderio-db0de517c7188e5b1e035c98a0e33e25"
end
