# Spree Product Feed

Spree Product Feed extension allows you to connect your Spree 4 store to Google Muerchant Center via a live RSS feed.

## Installation

1. Add this extension to your Gemfile with this line:

    ```ruby
    gem 'spree_product_feed', github: 'matthewkennedy/spree_product_feed'
    ```

2. Install the gem using Bundler

    ```ruby
    bundle install
    ```

3. Copy & run migrations

    ```ruby
    bundle exec rails g spree_product_feed:install
    ```

4. Restart your server

  If your server was running, restart it so that it can find the assets properly.

## Instructions For Use

Once installed this extension allows you to add products to an RSS feed found at: yourstoredomain.com/products.rss, this can then be submitted to your Google Merchant Centre account.


### Enhanced Listing

If you add a product with multiple variants to your product feed, the extension will recognise this product as a "complex product", automatically take each variant and create new feed item grouped under the mater product ID, creating an Enhanced Listing as shown in the image below.
![Google Merchant enhanced listing](https://lh3.googleusercontent.com/U52jfORqQSkO57TyGLFqdln08B7GnGYm5h0tyg91HxsN-4JoX7g2WR8CePG79udqEym1=w895)

### Adding Product Specific Data To Your Feed
If you have an item such as clothing that requires: ```<g:age_group>``` & ```<g:gender>``` to be passed into your Google Merchant Feed data, but do not wish to have these listed on your site as selectable variant options, you can add these to your product feed as follows.

In the example below we are adding ```<g:gender>``` to your product feed data.
- Form the admin visit **Properties** settings and click **New Property**.
- Add a new property using the following values: Name = ```Gender``` Presentation = ```product_feed_data```, click **Create**.
- Next edit your product and click the **Properties** tab form the sidebar options.
- Add a new property searching for ```Gender``` and then enter the value ```Female```.

This will add ```<g:gender>Female</g:gender>``` into your feed for this product and all of its variants.

### Adding Brand
Create a property Name = ```Brand``` Presentation = ```product_feed_data```, and this will be added to your feed data.

### Unique Identifier
You will notice that you have an option to add a unique identifier to the master product, and its variants. This is a requirement for most products passed into Google Merchant.


## ToDo
- Test in live merchant account.
- Write spec tests.
- Move the extensions feed options into their own sidebar view, from just stuck on the end of the main product view.

## Testing

First bundle your dependencies, then run `rake`. `rake` will default to building the dummy app if it does not exist, then it will run specs. The dummy app can be regenerated by using `rake test_app`.

```shell
bundle
bundle exec rake
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_product_feed/factories'
```

## Contributing

If you'd like to contribute, please take a look at the
[instructions](CONTRIBUTING.md) for installing dependencies and crafting a good
pull request.

Copyright (c) 2020 Matthew Kennedy, released under the New BSD License
