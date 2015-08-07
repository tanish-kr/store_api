# encoding : utf-8

module StoreApi
  module AppStore
    module Apps
      ##
      # app store detail class
      class Details
        include StoreApi::Request
        @@path = '/lookup'
        attr_accessor :id, :title, :cover_image, :developer,
          :developer_url, :categories, :category,
          :category_id, :category_ids, :price,
          :screenshot, :description, :rating_value,
          :rating_count, :rating_score, :release_notes, :date_published,
          :file_size, :software_version, :content_rating,
          :supported_devices, :bundle_id

        ##
        # initialize
        # @param [String] id
        # @param [String] lang
        # @param [Hash] proxy
        # @param [Hash] header
        def initialize(id, country=nil, proxy=nil, header=nil)
          params = {'id' => id, 'country' => country, 'entry' => 'software' }
          begin
            html = get(StoreApi::AppStore::HOST, @@path, params, StoreApi::AppStore::HTTPS, proxy, header)
            @raw_details = JSON.load(html)['results'][0]
            @id = @raw_details['trackId']
            @title = @raw_details['trackName']
            @cover_image = @raw_details['artworkUrl60']
            @developer = @raw_details['sellerName']
            @developer_url = @raw_details['artistViewUrl']
            @category = @raw_details['primaryGenreName']
            @categories = @raw_details['genres']
            @category_id = @raw_details['primaryGenreId']
            @category_ids = @raw_details['genreIds']
            @price = @raw_details['price']
            @screenshot = @raw_details['screenshotUrls']
            @description = @raw_details['description']
            @rating_value = @raw_details['averageUserRating']
            @rating_count = @raw_details['userRatingCount']
            @rating_score = @raw_details['averageUserRating']
            @release_notes = @raw_details['releaseNotes']
            @date_published = @raw_details['releaseDate']
            @file_size = @raw_details['fileSizeBytes']
            @software_version = @raw_details['version']
            @content_rating = @raw_details['contentAdvisoryRating']
            @supported_devices = @raw_details['supportedDevices']
            @bundle_id = @raw_details['bundleId']
          rescue => e
            puts e
          end
        end

        ##
        # get raw details
        # @return [Hash]
        def raw_details
          @raw_details
        end

      end

    end
  end
end
