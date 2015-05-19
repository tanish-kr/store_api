# encoding : utf-8
require 'spec_helper'

describe StoreApi::GooglePlay::Apps::Developer do

  it 'developer app list test' do
    developer_name = 'LINE Corporation'
    developer = StoreApi::GooglePlay::Apps::Developer.new(developer_name)
    puts developer.apps_list
    expect(developer.apps_list).not_to be nil
    expect(developer.apps_list.size).to be > 5
    expect(developer.apps_list[0][:developer]).to eq developer_name
  end

end

