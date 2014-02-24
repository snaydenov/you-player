require 'lastfm'
require 'launchy'
module YouPlayer
  module Search
   class LastFmSearch
      def initialize(api_key,api_secret)
        lastfm = Lastfm.new(api_key, api_secret)
        token = lastfm.auth.get_token
        Launchy.open("http://www.last.fm/api/auth?api_key=fee5b97dada87be6505634376ce7c9e4&token=#{token}")
        sleep(20)
        lastfm.session = lastfm.auth.get_session(token: token)['key']
      end
      def search(search_term)
      end
    end
    search = LastFmSearch.new("fee5b97dada87be6505634376ce7c9e4","5722f86438df114efbea8dffdd8c982e")
    
  end
end

 