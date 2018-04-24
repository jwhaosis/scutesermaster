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
    multi = EM::MultiRequest.new
    urls.each do |url|
      multi.add url, EM::HttpRequest.new("#{url}/test/reset/all").get
    end
    multi.callback do
      EM.stop
    end
  }
end

get '/test/reset/standard' do
  user_c = params[:users].to_i
  tweet_c = params[:tweets].to_i
  follower_c = params[:followers].to_i
  EM.run{
    multi = EM::MultiRequest.new
    urls.each do |url|
      multi.add url, EM::HttpRequest.new("#{url}/test/reset/standard?users=#{user_c}&tweets=#{tweet_c}&followers=#{follower_c}").get
    end
    multi.callback do
      EM.stop
    end
  }
end

get '/test/users/create' do
  count = params[:count].to_i
  tweets = params[:tweets].to_i
  EM.run{
    request = EM::HttpRequest.new("#{url[0]}/test/create?count=#{count}&tweets=#{tweets}").get
    EM.stop
  }
end

get '/test/user/testuser/tweets' do
  count = params[:count].to_i
  EM.run{
    request = EM::HttpRequest.new("#{url[0]}/test/user/testuser/tweets?count=#{count}").get
    EM.stop
  }
end

get '/test/user/testuser/follow' do
  count = params[:count].to_i
  EM.run{
    request = EM::HttpRequest.new("#{url[0]}/test/user/testuser/follow?count=#{count}").get
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
