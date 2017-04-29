require 'net/http'
require 'json'
require 'uri'
require 'date'

url = 'http://healthycanadians.gc.ca/recall-alert-rappel-avis/api/recent/en'
uri = URI(url)
response = Net::HTTP.get(uri)

recalls = JSON.parse(response)

# puts recalls['results']['ALL']

recalls['results']['ALL'].each do |doc|
  puts 'Recall ID: ' + doc['recallId']
  puts 'Recall Title: ' + doc['title']
  puts 'Category: ' + doc['category'].to_s
  puts 'Date Published: ' + Time.at(doc['date_published']).to_datetime.to_s
  puts 'URL: ' + doc['url']
  puts '**************'
  puts ''
end
