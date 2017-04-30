require 'net/http'
require 'json'
require 'uri'
require 'date'
require 'sinatra'
require 'sinatra/reloader' if development?

url = 'http://healthycanadians.gc.ca/recall-alert-rappel-avis/api/recent/en'
uri = URI(url)
response = Net::HTTP.get(uri)
recalls = JSON.parse(response)

# index page
get '/' do
  erb :index
end

# postal code pages
get '/allrecalls' do
  @all_recalls = recalls['results']['ALL']
  erb :allrecalls
end

get '/foodrecalls' do
  @food_recalls = recalls['results']['FOOD']
  erb :foodrecalls
end

get '/vehiclerecalls' do
  @vehicle_recalls = recalls['results']['VEHICLE']
  erb :vehiclerecalls
end

get '/healthrecalls' do
  @health_recalls = recalls['results']['HEALTH']
  erb :healthrecalls
end

get '/cpsrecalls' do
  @cps_recalls = recalls['results']['CPS']
  erb :cpsrecalls
end

get '/recalldetails/:id' do
  details_url = 'http://healthycanadians.gc.ca/recall-alert-rappel-avis/api/' + params[:id] + '/en'
  puts details_url
  uri = URI(details_url)
  response = Net::HTTP.get(uri)
  recall_item = JSON.parse(response)
  @recall_details = recall_item
  erb :recalldetails
end
