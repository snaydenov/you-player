module YouPlayer
  module Model
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
      attr_accessor : playlist_id, user_id, playlist_name

      def initialize(playlist_id, user_id, playlist_name)
        @playlist_id = playlist_id
        @user_id = user_id
        @playlist_name = playlist_name
      end
      end
	  end
  end
end