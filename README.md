# SpreeProductFeed

## ToDo

- Organise the code to recognise a basic product (no variants), Vs. a product with variants and process each type with of product differently to get variants displayed in google correctly via ```<g:item_group_id>```.
- Set up a way to add fields to the 'required product type options' of the feed. For example, in clothing, gender and age are required fields, but they would not be given as selectable variant, an example would be a men's leather jacket would not have a selectable option for gender, yet google requires gender in the feed data.
- Move Product Feed Option into their own sidebar view.
- Set up code to output all product properties into feed data where presentation is set to ```product_feed_data```.
- Find regular expression that reconises common barcode types: ISBN, UPC, GTIN, etc., set the code up to auto use correct idintifier in feed based on barcode type, if none reconised, pass as MPN. If thats too hard, add radio check option to alow user to set unique identifier type.

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

Once installed this extension allows you to add individual products to an  RSS feed found at: yourstoredomain.com/products.rss, this can then be submitted to your Google Merchant Centre acount.

#### Unique Idetifier
You will notice that you have an option to add a unique barcode to the master product, and its variants. This is a requirement for most products passed into Google Merchant Center.

#### Required Fields
If you have an item such as clothing that requires: ```<g:age_group>``` & ```<g:gender>``` or wish to pass in the product's ```<g:brand>``` to Google Merchant, you can add these in the using the Product Properties section.

- Visit Properties settings, add new property. In this example we are adding ```<g:gender>``` to your product feed. 
Add a new property using the following values: Name = ```Gender``` &  Presentation = ```product_feed_data```,click Create.
- Next Edit your product and click Properties tab in the sidebar. Add a new property searchng for ```Gender``` and then enter the value ```Female```. 

This will add ```<g:gender>Female</g:gender>``` into your feed for the product and its variants.

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

Copyright (c) 2020 [name of extension creator], released under the New BSD License
