require 'mysql2'
require '../lib/const'

	module Persistance
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
        :password => "tomandjerry31", :database => "you_player")
      end

      def get_user(username)
        result = @client.query("SELECT * FROM users WHERE user_username='#{username}';")
        User.new result.first["user_username"], result.first["user_password"], result.first["user_id"]
      end

      def save_user(user)
        @client.query("INSERT INTO users (user_username, user_password) VALUES ('#{user.username}','#{user.password}')")
      end

      def add_to_playlist(song_id, playlist_id)
        @client.query("INSERT INTO playlist_records (song_id, playlist_id) VALUES ('#{song_id}','#{playlist_id}')")
      end

      def remove_from_playlist(song_id, playlist_id)
        @client.query("DROP FROM playlist_records WHERE song_id = #{song_id} AND playlist_id = #{playlist_id}")
      end

      def add_playlist(user_id, playlist_name)
        @client.query("INSERT INTO playlists (playlist_user_id, playlist_name) VALUES ('#{user_id}','#{playlist_name}')")
      end

      def add_playlist(user_id, playlist_name)
        @client.query("INSERT INTO playlists (playlist_user_id, playlist_name) VALUES ('#{user_id}','#{playlist_name}')")
      end
      def remove_playlist(playlist_id)
        @client.query("DROP FROM playlists WHERE playlist_id = #{playlist_id}")
        @client.query("DROP FROM playlists_records WHERE playlist_id = #{playlist_id}")
      end
	  end
     class User
      attr_accessor :id, :username, :password

      def initialize(username, password, id = 0)
        @username = username
        @password = password
        @id = id
      end
    end
	  class InMemoryPersister
      
      def initialize
        @users = []
        @playlists = []
        @playlist_records = []
        @songs = []
      end

      def get_user(username)
        users.find { |user| user.username == username }
      end

      def add_user(user)
        users << user
      end

      def add_to_playlist(song_id,playlist_id)
        playlist_records << PlaylistRecord(song_id,playlist_id)
      end

      def remove_from_playlist(song_id, playlist_id)
        playlist_records = playlist_records.select { |record|  record.song_id !=song_id ||record.playlist_id != playlist_id }
      end

      def add_playlist(playlist)
        playlists << playlist
      end

      def remove_playlist(playlist)
        playlists = playlists.select { |list|  playlist.user_id !=list.user_id || playlist.playlist_name != list.playlist_name }
      end
	  end
    persister = Persistance.new(MySqlPersister.new)
	  Ivan =  User.new("ivan", "password")
	  puts persister.save_user Ivan
  end
