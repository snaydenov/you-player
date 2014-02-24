module YouPlayer
  module Search
      class YoutubeSearch
      def initialize
        @result = []
        @client = YouTubeIt::Client.new(:dev_key => "AIzaSyD6X9amWi-AsSQktLnQ9foJNUtO3IHoVCU")
      end
      def perform_searh(search_term)
        result = client.videos_by(:query => search_term).videos
      end
      
      def save_search(search_result)
        result.videos.each do |video|
          @result << Video.new(video.video_id, video.title, video.player_url, video.rating)
        end
      end
    end
  end
end