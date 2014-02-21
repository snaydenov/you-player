require 'rubygems'
require 'mysql2'
module YouPlayer

	module Persistance
	  class User
		attr_accessor :id, :username, :password

		def initialize(username, password, id = 0)
		  @username = username
		  @password = password
		  @id = id
		end
	  end

	  class Song
		attr_accessor :id, :title, :artist, :youtube_url

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

	  class Persistance
		def initialize(persister)
		  @persister = persister
		end

		def save_user(user)
		  @persister.save_user user
		end

		def get_user(username)
		  @persister.get_user username
		end

		def get_user_playlists(user_id)
		  @persister.get_user_playlists
		end

		def get_user_playlist(user, playlist_id)
		  @persister.get_user_playlist user, playlist_id
		end
	  end

	  class MySqlPersister
		def initialize
		  @client = Mysql2::Client.new(:host => "localhost", :username => "root",
			:password => "crocodile", :database => "you_player")
		end

		def get_user(username)
		  result = @client.query("SELECT * FROM users WHERE username='#{username}';")
		  User.new result.first["username"], result.first["password"], result.first["id"]
		end

		def add_user(user)
		  @client.query("INSERT INTO users (username, password) VALUES ('#{user.username}','#{user.password}')")
		end

		def add_to_playlist(song_id, playlist_id)
		  @client.query("INSERT INTO playlists (song_id, playlist_id) VALUES ('#{song_id}','#{playlist_id}')")
		end

		def remove_from_playlist(song_id, playlist_id)
		end

		def add_playlist(user_id, playlist_name)
		  @client.query("INSERT INTO playlist_names (user_id, name) VALUES ('#{user_id}','#{playlist_name}')")
		end

		def remove_playlist(playlist_id)
		end
	  end

	  class InMemoryPersister
		def initialize
		  @users = []
		  @playlists = []
		end

		def get_user(username)
		end

		def add_user(user)
		end

		def add_to_playlist(song_id, playlist_id)
		end

		def remove_from_playlist(song_id, playlist_id)
		end

		def add_playlist(user_id, playlist_name)
		end

		def remove_playlist(user_id, playlist_name)
		end
	  end

	  persister = Persistance.new(MySqlPersister.new)
	  Ivan =  User.new("ivan", "password")
	  puts persister.get_user("ivan").password
	end
end
