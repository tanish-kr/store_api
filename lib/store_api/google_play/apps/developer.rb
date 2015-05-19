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

        def initialize(developer_name,proxy=nil,header=nil)
          @@path = URI.escape("/store/apps/developer?id=#{developer_name}")
          @apps_list = []
          num = 60
          (0..1).each do |start|
            begin
            html = post(StoreApi::GooglePlay::HOST,@@path,{'start'=>start*60,'num'=>num},StoreApi::GooglePlay::HTTPS,proxy,header)
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
