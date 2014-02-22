module YouPlayer
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
  end
end