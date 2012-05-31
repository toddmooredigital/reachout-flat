require "sinatra"

set :public_folder, File.dirname(__FILE__) + '/assets'

get '/' do
 	erb :'templates/home'
end

get '/factsheet' do
 	erb :'templates/factsheet'
end

get '/category' do
 	erb :'templates/category'
end

get '/subcategory' do
 	erb :'templates/subcategory'
end

get '/emergency' do
 	erb :'templates/emegency'
end

get '/search' do
 	erb :'templates/search'
end

get '/login' do
 	erb :'templates/login'
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