# encoding : utf-8
require 'spec_helper'

describe StoreApi::AppStore::Apps::Details do

  it 'details test' do
    apps  = StoreApi::AppStore::Apps::Details.new('850417475','US')
    p apps.id
    expect(apps.id).not_to eq(nil), "Test id #{apps.id}"
    p apps.title
    expect(apps.title).not_to be nil
    p apps.cover_image
    expect(apps.cover_image).not_to be nil
    p apps.price
    expect(apps.price).not_to be nil
    p apps.developer
    expect(apps.developer).not_to be nil
    p apps.developer_url
    expect(apps.developer_url).not_to be nil
    p apps.category
    expect(apps.category).not_to be nil
    p apps.category_id
    expect(apps.category_id).not_to be nil
    p apps.screenshot
    expect(apps.screenshot.size).to be > 0
    p apps.description
    expect(apps.description).not_to be nil
    p apps.rating_score
    expect(apps.rating_score).not_to be nil
    p apps.rating_value
    expect(apps.rating_value).not_to be nil
    p apps.rating_count
    expect(apps.rating_count).not_to be nil
    p apps.release_notes
    expect(apps.release_notes).not_to be nil
    p apps.date_published
    expect(apps.date_published).not_to be nil
    p apps.file_size
    expect(apps.file_size).not_to be nil
    p apps.software_version
    expect(apps.software_version).not_to be nil
    p apps.content_rating
    expect(apps.content_rating).not_to be nil
    p apps.supported_devices
    expect(apps.supported_devices.size).to be > 0
    p apps.bundle_id
    expect(apps.bundle_id).not_to be nil
    # p apps.raw_details
    expect(apps.raw_details).not_to be nil
  end
end
