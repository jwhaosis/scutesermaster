require 'sinatra'
require 'em-http-request'
require 'redis'
require 'dotenv'
require "net/http"
require "uri"

Dotenv.load
$redis = Redis.new(:host => ENV["REDIS_URI"], :port => 10619, :password => ENV["REDIS_PASS"])
$redis.setnx "loadc", "100"
urls = ["https://scuteser.herokuapp.com","https://scuteser-2.herokuapp.com","https://scuteser-3.herokuapp.com","https://scuteser-4.herokuapp.com"]
dburls = ["https://scuteser-db1.herokuapp.com","https://scuteser-db2.herokuapp.com","https://scuteser-db3.herokuapp.com","https://scuteser-db4.herokuapp.com"]

get '/loaderio-87117f3cc6f3476f7ec8e1f03770d4f8/' do
  'loaderio-87117f3cc6f3476f7ec8e1f03770d4f8'
end

get '/' do
 $redis.incr "loadc"
 redirect urls[($redis.get "loadc").to_i%4]
end

post '/user/testuser/tweet' do
  $redis.incr "loadc"
  uri = URI.parse("#{urls[($redis.get "loadc").to_i%4]}/user/testuser/tweet")
  response = Net::HTTP.post_form(uri, {})
end

get '/sync' do
  EM.run {
    sync = EM::MultiRequest.new
    dburls.each do |dburl|
      sync.add dburl, EM::HttpRequest.new("#{dburl}/sync").post
    end
    sync.callback do
      EM.stop
    end
  }
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
  $redis.keys.each do |key|
    $redis.del(key)
  end
end

get '/test/reset/standard' do
  user_c = params[:users].to_i
  tweet_c = params[:tweets].to_i
  follower_c = params[:followers].to_i
  EM.run {
    seed = EM::MultiRequest.new
    urls.each do |url|
      seed.add url, EM::HttpRequest.new("#{url}/test/reset/standard?users=#{user_c}&tweets=#{tweet_c}&followers=#{follower_c}").get
    end
    seed.callback{
      EM.stop
    }
  }
  EM.run {
    sync = EM::MultiRequest.new
    dburls.each do |dburl|
      sync.add dburl, EM::HttpRequest.new("#{dburl}/sync").post
    end
    sync.callback do
      EM.stop
    end
  }
  $redis.keys.each do |key|
    $redis.del(key)
  end
end

get '/test/users/create' do
  count = params[:count].to_i
  tweets = params[:tweets].to_i
  EM.run{
    request = EM::HttpRequest.new("#{url[0]}/test/create?count=#{count}&tweets=#{tweets}").get
    request.callback{
      EM.stop
    }
    request.errback{
      EM.stop
    }
  }
end

get '/test/user/testuser/tweets' do
  count = params[:count].to_i
  EM.run{
    request = EM::HttpRequest.new("#{url[0]}/test/user/testuser/tweets?count=#{count}").get
    request.callback{
      EM.stop
    }
    request.errback{
      EM.stop
    }
  }
end

get '/test/user/testuser/follow' do
  count = params[:count].to_i
  EM.run{
    request = EM::HttpRequest.new("#{url[0]}/test/user/testuser/follow?count=#{count}").get
    request.callback{
      EM.stop
    }
    request.errback{
      EM.stop
    }
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

get '/:path1/:path2/:path3/:path4' do
  $redis.incr "loadc"
  redirect "#{urls[($redis.get "loadc").to_i%4]}/#{params[:path1]}/#{params[:path2]}/#{params[:path3]}/#{params[:path4]}"
end

get '/:path1/:path2/:path3/:path4/:path5' do
  $redis.incr "loadc"
  redirect "#{urls[($redis.get "loadc").to_i%4]}/#{params[:path1]}/#{params[:path2]}/#{params[:path3]}/#{params[:path4]}/#{params[:path5]}"
end

get '/:path1/:path2/:path3/:path4/:path5/:path6' do
  $redis.incr "loadc"
  redirect "#{urls[($redis.get "loadc").to_i%4]}/#{params[:path1]}/#{params[:path2]}/#{params[:path3]}/#{params[:path4]}/#{params[:path5]}/#{params[:path6]}"
end
