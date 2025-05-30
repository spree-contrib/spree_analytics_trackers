# ⚠️ Deprecation warning

> [!IMPORTANT]
> If you're on Spree 5, please head to [Spree Google Analytics gem](https://github.com/spree/spree_google_analytics). 
> This gem is only for Spree 4.

# Spree Analytics Trackers

[![Build Status](https://travis-ci.org/spree-contrib/spree_analytics_trackers.svg?branch=master)](https://travis-ci.org/spree-contrib/spree_analytics_trackers)

This extensions adds support for [Google Analytics Enhanced Ecommerce](https://developers.google.com/analytics/devguides/collection/analyticsjs/enhanced-ecommerce)
and [Segment Ecommerce](https://segment.com/docs/spec/ecommerce/v2/) tracking to [Spree Commerce](https://spreecommerce.org) stores.

Via Segment.com you can plug-in also a lot of additional vendors and services like:

* Mixpanel
* Kissmetrics
* Google Tag Manager
* Facebook Pixels
* Google Adwords remarketing
* [and hundreds others](https://segment.com/catalog#integrations/all)

No additional development required.

## Installation

1. Add this extension to your Gemfile with this line:

  ```ruby
  gem 'spree_analytics_trackers', '~> 2.0'
  ```

2. Install the gem using Bundler:

  ```ruby
  bundle install
  ```

3. Copy & run migrations

  ```ruby
  bundle exec rails g spree_analytics_trackers:install
  ```

4. Restart your server

  If your server was running, restart it so that it can find the assets properly.

## Testing

First bundle your dependencies, then run `rake`. `rake` will default to building the dummy app if it does not exist, then it will run specs. The dummy app can be regenerated by using `rake test_app`.

```shell
bundle
bundle exec rake
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_analytics_trackers/factories'
```

## License

Spree Analytics Trackers is copyright © 2017-2020
[Spark Solutions Sp. z o.o.][spark]. It is free software,
and may be redistributed under the terms specified in the
[LICENCE](LICENSE) file.

[LICENSE]: https://github.com/spree-contrib/spree_analytics_trackers/blob/master/LICENSE

## About Spark Solutions

[![Spark Solutions](http://sparksolutions.co/wp-content/uploads/2015/01/logo-ss-tr-221x100.png)][spark]

Spree Analytics Trackers is maintained by [Spark Solutions Sp. z o.o.](http://sparksolutions.co?utm_source=github).

We are passionate about open source software.
We are [available for hire][spark].

[spark]:http://sparksolutions.co?utm_source=github
