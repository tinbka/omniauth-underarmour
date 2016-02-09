require 'sinatra'
require 'omniauth-underarmour'

use Rack::Session::Cookie
use OmniAuth::Builder do
  provider :underarmour, '', '', { :redirect_uri => 'http://localhost:4567/auth/underarmour/callback' }
end

get '/' do
  <<-HTML
  <a href='/auth/underarmour'>Sign in with Fitbit</a>
  HTML
end
  
get '/auth/fitbit/callback' do
  # Do whatever you want with the data
  MultiJson.encode(request.env['omniauth.auth'])
end