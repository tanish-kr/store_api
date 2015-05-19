# encoding : utf-8

module StoreApi
  module GooglePlay
    module Card

        ##
        # card parts parse
        # @param [Nokogiri::XML::Docment] doc
        # @return [Array] card_list
        def parse(doc)
          card_list = []
          doc.css('.card-list > .card').each do |node|
            rank = node.css('.title').text.split('.')[0].strip
            if (/^[+-]?[0-9]+$/ =~ rank)
              rank = rank.to_i
            else
              rank = nil
            end
            card_list.push(
                {:id => node.css('.preview-overlay-container')[0]['data-docid'],
                :title => node.css('.title')[0]['title'].strip,
                :cover_image => node.css('.cover-image').attribute('src').value,
                :details_url => node.css('.title').attribute('href').value,
                :developer => node.css('.subtitle').attribute('title').value.strip,
                :price => node.css('.display-price')[0].text,
                :rank => rank}
            )
          end
          card_list
        end

    end
  end
end
