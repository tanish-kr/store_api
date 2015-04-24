# encoding : utf-8

module StoreApi
  module GooglePlay
    module Apps
      ##
      # == google play ranking class
      # @note specification
      #   - top path : '/store/apps/collection/ranking_type'
      #   - category path : '/store/apps/category/category_id/collection/ranking_type'
      #   - post data start: min 0 max 480 num:60
      class Ranking
        include StoreApi::Request
        attr_accessor :topchart
        ##
        # initialize
        # @param [String] ranking_type
        # @param [String] category_id
        # @param [String] lang
        # @param [Hash] proxy
        # @param [Hash] header
        # @see StoreApi::GooglePlay::RANKING_TYPE_LIST
        # @see StoreApi::GooglePlay::CATEGORY_ID_LIST
        def initialize(ranking_type=nil,category_id=nil,lang=nil,proxy=nil,header=nil)
          if category_id.nil?
            @@path = "/store/apps/collection/#{ranking_type}"
          else
            @@path = "/store/apps/category/#{category_id}/collection/#{ranking_type}"
          end
          @topchart = []
          num = 60
          (0..8).each do |start|
            begin
            html = post(StoreApi::GooglePlay::HOST,@@path,{'start'=>start*60,'num'=>num},StoreApi::GooglePlay::HTTPS,proxy,header)
            doc = Nokogiri::HTML(html,nil,'utf-8')
            parse(doc)
            rescue => e
              puts e.backtrace
              puts e.message
              break
            end
          end
        end

        def parse(doc)
          doc.css('.card-list > .card').each do |node|
            rank = node.css('.title').text.split('.')[0].strip
            if (/^[+-]?[0-9]+$/ =~ rank)
              rank = rank.to_i
            else
              rank = nil
            end
            @topchart.push(
                {:id => node.css('.preview-overlay-container')[0]['data-docid'],
                :title => node.css('.title')[0]['title'].strip,
                :cover_image => node.css('.cover-image').attribute('src').value,
                :details_url => node.css('.title').attribute('href').value,
                :developer => node.css('.subtitle').attribute('title').value.strip,
                :price => node.css('.display-price')[0].text,
                :rank => rank}
            )
          end
        end

      end

    end
  end
end
