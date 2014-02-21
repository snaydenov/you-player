require 'youtube_it'
module Search

end
  def initialize(query, params, provider)
    @provider = provider
    @query = query
    @params = params
    @result = []
  end
  
  def perform_searh
    @result = provider.perform_search(@query)
    save_search
  end

  def find_best_match
  
  end
  
  class YoutubeSearch
    def initialize
      @result = []
    end
    def perform_searh
      search_result = client.videos_by(@query)
      save_search(search_result)
      result
    end
    
    def save_search(search_result)
      result.videos.each do |video|
      @result << Video.new(video.video_id, video.title, video.player_url, video.rating)
    end
  end
end