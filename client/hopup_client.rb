
require 'rest-client'
require 'highline'
require 'json'

class HopupClient
  DIV=36
  DELAY=1
  DEMO_FILE_LOC = 'demo.html'

  def initialize
    @server = "http://ancient-plains-4741.herokuapp.com"
  end

  def parse_response(resp)
    JSON.parse(resp, symbolize_names: true)
  end

  def login
    printf "Enter email: "
    @email = gets.chomp
    secure = HighLine.new
    @pw = secure.ask("Enter password: ") { |q| q.echo = '*' }
    
    resp = RestClient.post("#{@server}/sessions.json", 
                              session: { email: @email, password: @pw })
    @client = parse_response(resp)
    @cookies = resp.cookies
    printf "Cookie: #{@cookies}"
  end

  def get_nearby_tags(lat, lng)
    resp = RestClient.post("#{@server}/hits.json", { lat: lat.to_s, lng: lng.to_s }, cookies: @cookies)
    hits = parse_response(resp)
  end

  def get_users
    resp = RestClient.get("#{@server}/users.json", cookies: @cookies)
    users = parse_response(resp)
  end

  def get_user(id)
    resp = RestClient.get("#{@server}/users/#{id}.json", cookies: @cookies)
    user = parse_response(resp)
  end

  #all topics
  def get_topics
    resp = RestClient.get("#{@server}/topics.json", cookies: @cookies)
    topics = parse_response(resp)
  end

  def get_topic(id)
    resp = RestClient.get("#{@server}/topics/#{id}.json", cookies: @cookies)
    topic = parse_response(resp)
  end

  #all tags i have created
  def get_tags
    resp = RestClient.get("#{@server}/tags.json", cookies: @cookies)
    tags = parse_response(resp)
  end

  def get_tag(id)
    resp = RestClient.get("#{@server}/tags/#{id}.json", cookies: @cookies)
    tag = parse_response(resp)
  end

  def logout
    resp = RestClient.delete("#{@server}/signout.json", cookie: @cookies)
    @cookies = nil
    parse_response(resp)
  end

  def demo
    @alltagshit = []
    printf "Please enter your starting location: "
    starting = gets.chomp
    printf "Please enter you ending location: "
    ending = gets.chomp

    slat, slng = get_coords(starting)
    elat, elng = get_coords(ending)

    dlat = (elat - slat)/DIV
    dlng = (elng - slng)/DIV

    clat, clng = slat, slng
    output = File.new(DEMO_FILE_LOC,'w')
    output << "<!DOCTYPE html><html>"
    output << "<img src='http://maps.googleapis.com/maps/api/staticmap?center=#{clat},#{clng}&zoom=15&size=1000x1000&amp;sensor=false&amp;markers=color:red%7Clabel:M%7C#{clat},#{clng}'/>"
    output << "</html>"
    output.close

    puts "Demo file is found at #{DEMO_FILE_LOC}"
    puts "Demo is ready, press enter to continue"
    gets

    DIV.times do
      hits = get_nearby_tags(clat,clng)
      markers = []
      tags_text = []
      markers << "markers=color:red%7Clabel:M%7C#{clat},#{clng}"
      hits.each do |hit|
        tag = get_tag(hit[:tag_id])
        topic = get_topic(tag[:topic_id])
        creator = get_user(topic[:creator_id])
        tags_text << "#{creator[:name]}: #{tag[:text]}"
        markers << "markers=color:blue%7Clabel:S%7C#{tag[:lat]},#{tag[:lng]}"
      end
      @alltagshit += hits
      output = File.new(DEMO_FILE_LOC,'w')
      output << "<!DOCTYPE html><html>"
      output << "<h1>#{tags_text.join('<br/>')}</h1>"
      output << "<br/><img src='http://maps.googleapis.com/maps/api/staticmap?center=#{clat},#{clng}&zoom=15&size=1000x1000&amp;sensor=false&amp;#{markers.join('&')}' />"
      output << "</html>"
      output.close
      clat += dlat
      clng += dlng
      sleep(DELAY)
    end
    @alltagshit
  end

  def get_coords(a_location)
    path = "https://maps.googleapis.com/maps/api/geocode/json"
    query_values = {
      address: "#{a_location}",
      sensor: 'false'
    }
    loc_parsed = parse_response(RestClient.get(path, { :params => query_values }))
    lat = loc_parsed[:results][0][:geometry][:location][:lat]
    lng = loc_parsed[:results][0][:geometry][:location][:lng]
    [lat.to_f,lng.to_f]
  end

end
