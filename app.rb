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
  target = 1 + (redis.get "loadc").to_i%4

  if target == 1
    redirect first_uri + second_uri
  else
    redirect first_uri + "-#{target}" + second_uri
  end
end

get '/' do

end

get '/:path1' do
  second_uri += params[:path1]
end

get '/:path1/' do
  second_uri += params[:path1]
end

get '/:path1/:path2' do
  second_uri = second_uri + params[:path1] + '/' + params[:path2]
end

get '/:path1/:path2/' do
  second_uri = second_uri + params[:path1] + '/' + params[:path2]
end

get '/:path1/:path2/:path3' do
  second_uri = second_uri + params[:path1] + '/' + params[:path2] + '/' + params[:path3]
end

get '/:path1/:path2/:path3/' do
  second_uri = second_uri + params[:path1] + '/' + params[:path2] + '/' + params[:path3]
end
