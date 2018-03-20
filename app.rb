require 'sinatra'

get '/' do
  redirect "http://scuteser.herokuapp.com"
end

get '/blank' do
  erb :master
end

get '/test' do

end

get '/loaderio-db0de517c7188e5b1e035c98a0e33e25/' do
  "loaderio-db0de517c7188e5b1e035c98a0e33e25"
end
