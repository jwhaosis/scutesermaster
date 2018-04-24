require 'sinatra'
require 'em-http-request'
require 'redis'
require 'dotenv'

Dotenv.load
$redis = Redis.new(:host => ENV["REDIS_URI"], :port => 10619, :password => ENV["REDIS_PASS"])
$redis.setnx "loadc", "100"
urls = ["https://scuteser.herokuapp.com","https://scuteser-2.herokuapp.com","https://scuteser-3.herokuapp.com","https://scuteser-4.herokuapp.com"]

get '/loaderio-87117f3cc6f3476f7ec8e1f03770d4f8/' do
  'loaderio-87117f3cc6f3476f7ec8e1f03770d4f8'
end

get '/' do
 $redis.incr "loadc"
 redirect urls[($redis.get "loadc").to_i%4]
end

get '/test/reset/all' do
  EM.run {
    urls.each do |url|
      request = EM::HttpRequest.new("#{url}/test/reset/all").post
    end
    EM.stop
  }
end

get '/:path1' do
  $redis.incr "loadc"
  redirect "#{urls[($redis.get "loadc").to_i%4]}/#{params[:path1]}"
end

get '/:path1/:path2' do
  $redis.incr "loadc"
  redirect "#{urls[($redis.get "loadc").to_i%4]}/#{params[:path1]}/#{params[:path2]}"
end

get '/:path1/:path2/:path3' do
  $redis.incr "loadc"
  redirect "#{urls[($redis.get "loadc").to_i%4]}/#{params[:path1]}/#{params[:path2]}/#{params[:path3]}"
end
