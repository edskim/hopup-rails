
require 'rest-client'
require 'highline'
require 'json'

class HopupClient

  def initialize
    @server = "http://localhost:3000"
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
end
