require 'youtube_it'
require '../search/search.rb'
module YouPlayer
  module Search
    
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
  end
end


