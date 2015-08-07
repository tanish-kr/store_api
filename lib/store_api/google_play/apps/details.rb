# encoding : utf-8

module StoreApi
  module GooglePlay
    module Apps
      ##
      # google play detail class
      class Details
        include StoreApi::Request
        @@path = '/store/apps/details'
        attr_accessor :id,:title,:cover_image,:developer,:developer_url,:category,:category_id,
          :category_url,:badge_title,:price,:google_plus,:video_url,:screenshot,:description,
          :rating_value,:rating_count,:rating_score,:rating_map,:whatsnew,:date_published,
          :file_size,:downloads,:software_version,:operating_system,:content_rating,
          :developer_links,:developer_address
        ##
        # initialize
        # @param [String] id
        # @param [String] lang
        # @param [Hash] proxy
        # @param [Hash] header
        def initialize(id,lang=nil,proxy=nil,header=nil)
          params = {'id' => id }
          if !lang.nil?
            params['hl'] = lang
          end
          begin
            html = get(StoreApi::GooglePlay::HOST,@@path,params,StoreApi::GooglePlay::HTTPS,proxy,header)
            doc = Nokogiri::HTML(html,nil,'utf-8')
            @id = id

            content_xpath = "id('body-content')"
            doc.xpath("#{content_xpath}//div[@class='details-info']").each do |node|
              # puts node.methods
              @title = node.css('.document-title').text.strip
              @cover_image = node.css('.cover-image').attribute('src').value
              @developer = node.css('.primary').text.strip
              @developer_url = node.css('.primary').attribute('href').value
              @category = node.css('.category').text.strip
              @category_url = node.css('.category').attribute('href').value
              @category_id = node.css('.category').attribute('href').value.split("/")[4]
              @badge_title = node.css('.badge-title').text.strip
              @price = node.xpath("//*[@class='price buy id-track-click']//*[@itemprop='price']/@content").text
            end

            thumbnails_xpath = "#{content_xpath}//div[@class='thumbnails']"
            @screenshot = doc.xpath("#{thumbnails_xpath}/img").map {|node| node.attribute('src').value }
            @video_url = doc.xpath("#{thumbnails_xpath}/span[@class='details-trailer']/span[@class='preview-overlay-container']/@data-video-url").text
            @description = doc.xpath("#{content_xpath}//div[@itemprop='description']").to_html
            @rating_score = doc.xpath("#{content_xpath}//div[@class='rating-box']//div[@class='score']").text
            rating_xpath = "#{content_xpath}////div[@class='rating-box']"
            @rating_value = doc.xpath("#{rating_xpath}//*[@itemprop='ratingValue']/@content").text
            @rating_count = doc.xpath("#{rating_xpath}//*[@itemprop='ratingCount']/@content").text

            @rating_map = {}
            doc.xpath("#{rating_xpath}//div[@class='rating-histogram']/div").each do |node|
              star_num = node.css(".bar-label").text.strip
              @rating_map[star_num.to_i] = node.css(".bar-number").text.gsub(',','')
            end

            @whatsnew = doc.xpath("#{content_xpath}//div[@class='details-section whatsnew']//div[@class='recent-change']").text
            metadata_xpath = "#{content_xpath}//div[@class='details-section metadata']//div[@class='meta-info']"
            @date_published = doc.xpath("#{metadata_xpath}//div[@itemprop='datePublished']").text
            @file_size = doc.xpath("#{metadata_xpath}//div[@itemprop='fileSize']").text
            @file_size = !@file_size.nil? ? @file_size.strip : nil
            @downloads = doc.xpath("#{metadata_xpath}//div[@itemprop='numDownloads']").text
            @downloads = !@downloads.nil? ? @downloads.strip : nil
            @software_version = doc.xpath("#{metadata_xpath}//div[@itemprop='softwareVersion']").text
            @software_version = !@software_version.nil? ? @software_version.strip : nil
            @operating_system = doc.xpath("#{metadata_xpath}//div[@itemprop='operatingSystems']").text
            @operating_system = !@operating_system.nil? ? @operating_system.strip : nil
            @content_rating = doc.xpath("#{metadata_xpath}//div[@itemprop='contentRating']").text
            @content_rating = !@content_rating.nil? ? @content_rating.strip : nil
            @developer_address = doc.xpath("#{metadata_xpath}//div[@class='content physical-address']").text
            @developer_address = !@developer_address.nil? ? @developer_address.strip : nil
            @developer_links = []
            doc.xpath("#{content_xpath}//div[@class='details-section metadata']//div[@class='content contains-text-link']/a[@class='dev-link']").each do |node|
              @developer_links.push({'text' => node.text,'link' => node.attribute('href').value})
            end
          rescue => e
            puts e
          end
        end
      end

    end
  end
end
