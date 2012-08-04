module TagsHelper

def get_google_locations(a_location)
    path = "https://maps.googleapis.com/maps/api/geocode/json"
    query_values = {
        address: "#{a_location}",
        sensor: 'false'
      }
    RestClient.get(path, { :params => query_values })
end

def request_coordinates(address)
  locations_json = get_google_locations(address)
  locations_parsed = JSON.parse(locations_json,  :symbolize_names => true)
  lat = locations_parsed[:results][0][:geometry][:location][:lat]
  lng = locations_parsed[:results][0][:geometry][:location][:lng]
  addr = locations_parsed[:results][0][:formatted_address]
  [addr, lat, lng]
end

end
