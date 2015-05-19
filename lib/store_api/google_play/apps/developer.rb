# encoding : utf-8

module StoreApi
  module GooglePlay
    module Apps
      ##
      # google play developer class
      class Developer
        include StoreApi::Request
        include StoreApi::GooglePlay::Card
        attr_accessor :apps_list

        def initialize(developer_name,lang=nil,proxy=nil,header=nil)
          params = {'id' => developer_name }
          if !lang.nil?
            params['hl'] = lang
          end
          @@path = URI.escape("/store/apps/developer")
          @apps_list = []
          num = 60
          (0..1).each do |start|
            begin
              params['start'] = start*60
              params['num'] = num
              html = post(StoreApi::GooglePlay::HOST,@@path,params,StoreApi::GooglePlay::HTTPS,proxy,header)
              doc = Nokogiri::HTML(html,nil,'utf-8')
              @apps_list.concat(parse(doc))
            rescue => e
              puts e.backtrace
              puts e.message
              break
            end
          end
        end
      end

    end
  end
end
