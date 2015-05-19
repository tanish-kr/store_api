# encoding : utf-8

module StoreApi
  module GooglePlay
    module Apps
      ##
      # google play search class
      class Search
        include StoreApi::Request
        include StoreApi::GooglePlay::Card
        attr_accessor :search_list

        def initialize(search_word,limit=nil,proxy=nil,header=nil)
          @@path = URI.escape("/store/search?q=#{search_word}&c=apps")
          @search_list = []
          num = 60
          # TODO search limit
          (0..2).each do |start|
            begin
            html = post(StoreApi::GooglePlay::HOST,@@path,{'start'=>start*60,'num'=>num},StoreApi::GooglePlay::HTTPS,proxy,header)
            doc = Nokogiri::HTML(html,nil,'utf-8')
            @search_list.concat(parse(doc))
            rescue => e
              puts e.backtrace
              puts e.message
              break
            end
          end
        end

        def main
        end
      end

    end
  end
end
