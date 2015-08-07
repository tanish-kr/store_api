# encoding : utf-8
require 'spec_helper'

describe StoreApi::GooglePlay::Apps::Details do

  it 'details test' do
    apps  = StoreApi::GooglePlay::Apps::Details.new('com.king.candycrushsodasaga','en')
    # apps  = StoreApi::GooglePlay::Apps::Details.new('com.toiletgaman','en')
    puts apps
    expect(apps.title).not_to be nil
    expect(apps.cover_image).not_to be nil
    expect(apps.price).not_to be nil
    expect(apps.developer).not_to be nil
    expect(apps.developer_url).not_to be nil
    expect(apps.category).not_to be nil
    expect(apps.category_url).not_to be nil
    expect(apps.category_id).not_to be nil
    expect(apps.badge_title).not_to be nil
    expect(apps.screenshot.size).to be > 0
    expect(apps.video_url).not_to be nil
    expect(apps.description).not_to be nil
    expect(apps.rating_score).not_to be nil
    expect(apps.rating_value).not_to be nil
    expect(apps.rating_count).not_to be nil
    expect(apps.rating_map.size).to be > 0
    expect(apps.whatsnew).not_to be nil
    expect(apps.date_published).not_to be nil
    expect(apps.file_size).not_to be nil
    expect(apps.downloads).not_to be nil
    expect(apps.software_version).not_to be nil
    expect(apps.operating_system).not_to be nil
    expect(apps.content_rating).not_to be nil
    expect(apps.developer_address).not_to be nil
    expect(apps.developer_links.size).to be > 0
  end
end
