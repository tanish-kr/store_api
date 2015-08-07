# encoding : utf-8
require 'spec_helper'

describe StoreApi::GooglePlay::Apps::Details do

  it 'details test' do
    apps  = StoreApi::GooglePlay::Apps::Details.new('com.king.candycrushsodasaga','en')
    # apps  = StoreApi::GooglePlay::Apps::Details.new('com.toiletgaman','en')
    puts 'title : ' + apps.title
    expect(apps.title).not_to be nil
    puts 'cover_image : ' + apps.cover_image
    expect(apps.cover_image).not_to be nil
    puts 'price : ' + apps.price
    expect(apps.price).not_to be nil
    puts 'developer : ' + apps.developer
    expect(apps.developer).not_to be nil
    puts 'developer_url : ' + apps.developer_url
    expect(apps.developer_url).not_to be nil
    puts 'category : ' + apps.category
    expect(apps.category).not_to be nil
    puts 'category_url : ' + apps.category_url
    expect(apps.category_url).not_to be nil
    puts 'category_id : ' + apps.category_id
    expect(apps.category_id).not_to be nil
    puts 'badge_title : ' + apps.badge_title
    expect(apps.badge_title).not_to be nil
    puts 'screenshot : ' + apps.screenshot.to_s
    expect(apps.screenshot.size).to be > 0
    puts 'video_url : ' + apps.video_url
    expect(apps.video_url).not_to be nil
    puts 'description : ' + apps.description
    expect(apps.description).not_to be nil
    puts 'rating_score : ' + apps.rating_score
    expect(apps.rating_score).not_to be nil
    puts 'rating_value : ' + apps.rating_value
    expect(apps.rating_value).not_to be nil
    puts 'rating_count : ' + apps.rating_count
    expect(apps.rating_count).not_to be nil
    puts 'rating_map : ' + apps.rating_map.to_s
    expect(apps.rating_map.size).to be > 0
    puts 'whatsnew : ' + apps.whatsnew
    expect(apps.whatsnew).not_to be nil
    puts 'date_published : ' + apps.date_published
    expect(apps.date_published).not_to be nil
    puts 'file_size : ' + apps.file_size
    expect(apps.file_size).not_to be nil
    puts 'downloads : ' + apps.downloads
    expect(apps.downloads).not_to be nil
    puts 'software_version : ' + apps.software_version
    expect(apps.software_version).not_to be nil
    puts 'operating_system : ' + apps.operating_system
    expect(apps.operating_system).not_to be nil
    puts 'content_rating : ' + apps.content_rating
    expect(apps.content_rating).not_to be nil
    puts 'developer_address : ' + apps.developer_address
    expect(apps.developer_address).not_to be nil
    puts 'developer_links : ' + apps.developer_links.to_s
    expect(apps.developer_links.size).to be > 0
  end
end
