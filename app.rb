require 'sinatra'
require 'em-http-request'

get '/' do
  redirect 'http://scuteser.herokuapp.com/'
  #EventMachine.run do
  #  http = EventMachine::HttpRequest.new('http://scuteser.herokuapp.com/').get
  #  http.callback { p http.last_effective_url }
  #end
end

get '/blank' do
  erb :master
end

get '/test' do

end

get '/loaderio-db0de517c7188e5b1e035c98a0e33e25/' do
  "loaderio-db0de517c7188e5b1e035c98a0e33e25"
end
