# encoding : utf-8
require 'spec_helper'

describe StoreApi do
  it 'has a version number' do
    expect(StoreApi::VERSION).not_to be nil
  end

  it 'http request test' do
    extend StoreApi::Request
    host = 'play.google.com'
    path = '/store'
    html = get(host,path)
    expect(html).not_to be nil
  end
end
