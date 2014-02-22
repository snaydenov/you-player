module YouPlayer
  module Persistance
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
  end
end