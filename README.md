# StoreApi
[![Coverage Status](https://coveralls.io/repos/kitaro-tn/store_api/badge.svg)](https://coveralls.io/r/tatsu07/store_api) [![Build Status](https://travis-ci.org/kitaro-tn/store_api.svg?branch=master)](https://travis-ci.org/tatsu07/store_api)

This is the API to get the data from GooglePlay and AppStore and KindleStore and WindowsStore

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'store_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install store_api

## Usage

```ruby
require 'store_api'
```

#### GooglePlay
- app details

```ruby
apps = StoreApi::GooglePlay::Apps::Details.new('com.king.candycrushsodasaga')
# Can be specified language
apps = StoreApi::GooglePlay::Apps::Details.new('com.king.candycrushsodasaga','en')

puts apps.title
>>> Candy Crush Soda Saga
```
- ranking chart

```ruby
# Top Grossing Android Apps
ranking = StoreApi::GooglePlay::Apps::Ranking.new('topgrossing')
puts ranking.topchart
# Top Grossing Games
ranking = StoreApi::GooglePlay::Apps::Ranking.new('topgrossing','GAME')
puts ranking.topchart
# Trending Apps
trending_apps = StoreApi::GooglePlay::Apps::Ranking.new('movers_shakers')
puts trending_apps.topchart
```

- search apps

```ruby
search_apps = StoreApi::GooglePlay::Apps::Search.new('candy crush')
```

- developer apps

```ruby
developer_apps = StoreApi::GooglePlay::Apps::Developer.new('King')
```

#### AppStore
- app details

```ruby
apps = StoreApi::AppStore::Apps::Details.new('850417475', 'US')
puts apps.title
>>> "Candy Crush Soda Saga"
```

- ranking chart

```ruby
# us topgrossingapplications Games ranking
ranking = StoreApi::AppStore::Apps::Ranking.new('topgrossingapplications', '7001', 'us', 20)
puts ranking.topchart
```

## Contributing

1. Fork it ( https://github.com/tatsu07/store_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
