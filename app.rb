gem 'net/http'
gem 'json'


url = 'http://healthycanadians.gc.ca/recall-alert-rappel-avis/api/recent/en'
uri = URI(url)
response = Net::HTTP.get(uri)

if response == '200'
    result = JSON.parse(response)
    puts result
else
    puts 'ERROR!!!'
end
