require 'youtube_it'
class Song
  attr_accessor :video_id, :title, :url, :rating, :information
  
  def initialize(video_id, title, url, rating, information)
    @video_id, @title, @url, @rating = video_id, title, url, rating, information
  end
end

class Playlist
  attr_accessor :songs, :date_created

  def initialize(date_created)
    @date_created = date_created
    @songs = []
  end

  def add_song(song)
    @songs << song
  end
end

class User
  attr_accessor :username, :password

  def initialize(username, password)
    @username = username;
    @password = password;
  end
end

class Euristics
  def initialize(persister)
    @persister = persister
  end
  def filter_results(result)

  end
end
class Searcher
  def initialize
    @client = YouTubeIt::Client.new
    @euristics = Euristics.new
  end
  def get_url(string)
    result = client.videos_by(:query => string)
    euristics.filter_results result
  end
end

class Player
  def initialize
    @persister = Persister.new
    @searcher = Searcher.new
  end
end
client = YouTubeIt::Client.new
result = client.videos_by(:query => "bethoven third")
puts result.videos.first.player_url
