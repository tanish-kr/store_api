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

        def initialize(search_word,lang=nil,limit=nil,proxy=nil,header=nil)
          params = {'q' => search_word,'c' => 'apps' }
          if !lang.nil?
            params['hl'] = lang
          end
          @@path = URI.escape("/store/search")
          @search_list = []
          num = 60
          # TODO search limit
          (0..2).each do |start|
            begin
              params['start'] = start*60
              params['num'] = num
              html = post(StoreApi::GooglePlay::HOST,@@path,params,StoreApi::GooglePlay::HTTPS,proxy,header)
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
