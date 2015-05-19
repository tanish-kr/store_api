# encoding : utf-8
require 'spec_helper'

describe StoreApi::GooglePlay::Apps::Ranking do

  it 'ranking test' do
    ranking = StoreApi::GooglePlay::Apps::Ranking.new('topgrossing','GAME')
    expect(ranking.topchart).not_to be nil
    expect(ranking.topchart.size).to be >= 540 
    # ranking = StoreApi::GooglePlay::Apps::Ranking.new('topselling_free')
    # expect(ranking.topchart).not_to be nil
    # expect(ranking.topchart.size).to be >= 540 
    ranking = StoreApi::GooglePlay::Apps::Ranking.new('editors_choice')
    expect(ranking.topchart).not_to be nil
    ranking = StoreApi::GooglePlay::Apps::Ranking.new('movers_shakers')
    expect(ranking.topchart).not_to be nil
    ranking = StoreApi::GooglePlay::Apps::Ranking.new('tablet_featured')
    expect(ranking.topchart).not_to be nil
    ranking = StoreApi::GooglePlay::Apps::Ranking.new('featured')
    expect(ranking.topchart).not_to be nil
  end

end
