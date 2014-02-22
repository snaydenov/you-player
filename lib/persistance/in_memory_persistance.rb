module YouPlayer
  module Persistance
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
  end
end