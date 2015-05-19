# encoding : utf-8
require 'spec_helper'

describe StoreApi::GooglePlay::Apps::Search do

  it 'app search test' do
    search_word = 'モンスト'
    search = StoreApi::GooglePlay::Apps::Search.new(search_word)
    expect(search.search_list).not_to be nil
    expect(search.search_list.size).to be > 10 
  end

end
