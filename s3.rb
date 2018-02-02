require 'json'

file = File.read('keys.json')

data = JSON.parse(file)

# Making URL from array of keys
array = data.map do |key|
    key = "https://aol-public.s3.amazonaws.com/#{key}"
end

print array
print "\n"

# Sending all URLs 
