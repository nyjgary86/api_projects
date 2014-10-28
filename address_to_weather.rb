require 'open-uri'
require 'json'

# If you experience an error relating to SSL,
#   uncomment the following two lines:

# require 'openssl'
# OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

puts "Let's get the weather forecast for your address."

puts "What is the address you would like to know the weather for?"
the_address = gets.chomp
url_safe_address = URI.encode(the_address)

# Your code goes below.

full_url = "http://maps.googleapis.com/maps/api/geocode/json?address=" + url_safe_address
raw_data = open(full_url).read
parsed_data = JSON.parse(raw_data)

the_latitude = parsed_data["results"][0]["geometry"]["location"]["lat"].to_s
the_longitude = parsed_data["results"][0]["geometry"]["location"]["lng"].to_s

full_url = "https://api.forecast.io/forecast/048adcb08a629d1532b3b963652b9288/" + the_latitude + "," + the_longitude
raw_data = open(full_url).read
parsed_data = JSON.parse(raw_data)

the_temperature = parsed_data["currently"]["temperature"]
the_hour_outlook = parsed_data["hourly"]["data"][0]["summary"]
the_day_outlook = parsed_data["daily"]["data"][0]["summary"]

puts "The current temperature at #{the_address} is #{the_temperature} degrees."
puts "The outlook for the next hour is: #{the_hour_outlook}"
puts "The outlook for the next day is: #{the_day_outlook}"
