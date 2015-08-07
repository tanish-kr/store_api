# encoding : utf-8

module StoreApi
  module AppStore
    module Apps

      class Ranking
        include StoreApi::Request
        attr_accessor :topchart

        ##
        # initialize
        # @param [String] ranking_type
        # @param [String] category_id
        # @param [String] country
        # @param [Integer] limit
        # @param [Hash] proxy
        # @param [Hash] header
        def initialize(ranking_type=nil, category_id=nil, country=nil, limit=10, proxy=nil, header=nil)
          if category_id.nil?
            @@path = "/#{country}/rss/#{ranking_type}/limit=#{limit}/json"
          else
            @@path = "/#{country}/rss/#{ranking_type}/limit=#{limit}/genre=#{category_id}/json"
          end

          @topchart = []
          feed_data = JSON.load(get(StoreApi::AppStore::HOST, @@path,
            nil, StoreApi::AppStore::HTTPS, proxy, header))['feed']['entry']

          feed_data.each.with_index(1) do |entry, rank|
            @topchart.push({
              :id => entry['id']['attributes']['im:id'],
              :title => entry['im:name']['label'],
              :bundle_id => entry['id']['attributes']['im:bundleId'],
              :category_id => entry['category']['attributes']['im:id'],
              :category => entry['category']['attributes']['label'],
              :cover_image => entry['im:image'][0]['label'],
              :price => entry['im:price']['attributes']['amount'],
              :developer => entry['im:artist']['label'],
              :release_date => entry['im:releaseDate']['label'],
              :rank => rank
            })
          end
        end

      end

    end
  end
end
