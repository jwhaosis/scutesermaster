require 'sinatra'
require 'em-http-request'
require 'redis'
require 'dotenv'

Dotenv.load
uri = URI.parse(ENV["REDIS_URI"])
redis = Redis.new(:host => uri, :port => 10619, :password => ENV["REDIS_PASS"])
redis.setnx "loadc", "100"
first_uri = 'http://scuteser'
second_uri = '.herokuapp.com/'

after do
  redis.incr "loadc"
  uri = first_uri + second_uri
  target = 1 + (redis.get "loadc").to_i%4
  if target == 1
    redirect first_uri + second_uri
  elsif
    redirect first_uri + "-#{target}" + second_uri
  end
end

get '/' do

end

get '/:path1' do
  second_uri += params[:path1]
end

get '/:path1/:path2' do
  second_uri = second_uri + params[:path1] + '/' + params[:path2]
end

get '/:path1/:path2/:path3' do
  second_uri = second_uri + params[:path1] + '/' + params[:path2] + '/' + params[:path3]
end

get '/loaderio-87117f3cc6f3476f7ec8e1f03770d4f8/' do
  "loaderio-87117f3cc6f3476f7ec8e1f03770d4f8"
end

get '/loaderio-db0de517c7188e5b1e035c98a0e33e25/' do
  "loaderio-db0de517c7188e5b1e035c98a0e33e25"
end
