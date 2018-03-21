require 'sinatra'

$iter = 0

get '/' do
  if $iter == 0
    redirect "http://scuteser.herokuapp.com"
    $iter+=1
  else
    $iter-=1
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
