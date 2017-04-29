source 'https://rubygems.org'
gem 'net/http'
gem 'json'


url = 'http://healthycanadians.gc.ca/recall-alert-rappel-avis/api/recent/en'
uri = URI(url)
response = Net::HTTP.get(uri)
result = JSON.parse(response)