# encoding : utf-8
require 'spec_helper'

describe StoreApi::AppStore::Apps::Ranking do
  it "itunes ios ranking test" do
    ranking = StoreApi::AppStore::Apps::Ranking
    .new('topgrossingapplications', '7001', 'us', 20)
    puts ranking.topchart
    expect(ranking.topchart).not_to be nil
    expect(ranking.topchart.size).to eq(20)
    expect(ranking.topchart[0][:rank]).to eq(1)
  end
end
