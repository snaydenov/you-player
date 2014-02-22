require 'youtube_it'
module YouTube
  module Search
    class Search
      
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
    class FuzzyMatch
      def levenshtein_difference(first, second)
        matrix = [(0..first.length).to_a]
        (1..second.length).each do |j|
          matrix << [j] + [0] * (first.length)
        end
       
        (1..second.length).each do |i|
          (1..first.length).each do |j|
            if first[j-1] == second[i-1]
              matrix[i][j] = matrix[i-1][j-1]
            else
              matrix[i][j] = [
                matrix[i-1][j],
                matrix[i][j-1],
                matrix[i-1][j-1],
              ].min + 1
            end
          end
        end
        return matrix.last.last
      end
      def letters_match(first, second)
        result = 0
        first.downcase.chars do |first_char|
          second.downcase.chars do |second_char|
            if second_char == first_char
              result += 1
              second.slice!(1..-1)
              break
            end
          end
        end
        result == second.length
        
      end
      def find_best_match
    
      end
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
  end
end

