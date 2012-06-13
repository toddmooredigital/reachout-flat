require "sinatra"

set :public_folder, File.dirname(__FILE__) + '/assets'

get '/' do
 	erb :'templates/home'
end

get '/factsheet' do
 	erb :'templates/factsheet'
end

get '/story' do
 	erb :'templates/story'
end

get '/category' do
 	erb :'templates/category'
end

get '/subcategory' do
 	erb :'templates/subcategory'
end

get '/emergency' do
 	erb :'templates/emergency'
end

get '/search' do
 	erb :'templates/search'
end

get '/login' do
 	erb :'templates/login'
end

post '/login' do
 	status 200
 	body "ok"
end

get '/signup' do
 	erb :'templates/signup'
end

post '/signup' do
 	status 200
 	body "ok"
end

# Mobile templates

get '/mobile/home' do
 	erb :'mobile/home'
end

get '/mobile/home-a' do
 	erb :'mobile/home-a'
end

get '/mobile/category' do
 	erb :'mobile/category'
end

get '/mobile/subcategory' do
 	erb :'mobile/subcategory'
end

get '/mobile/story' do
 	erb :'mobile/story'
end

# Non templates

get '/modules' do
 	erb :'patterns/modules'
end

get '/buttons' do
 	erb :'patterns/buttons'
end

get '/patterns' do
 	erb :'patterns/patterns'
end



# use Rack::Auth::Basic, "Restricted Area" do |username, password|
#   [username, password] == ['admin', 'password']
# end