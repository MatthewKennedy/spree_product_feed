# Spree Product Feed

Give your Spree store instant access to some of the best product advertising platforms available.

The Spree Product Feed extension allows you to connect your Spree store directly to Google Merchant Center and Facebook Catalog via a live RSS feed.

Additionally, your products can then be indirectly imported from Google Merchant Center across to Microsoft Advertising, giving you access to Bing Shopping, Yahoo Shopping and other partners of Microsoft Advertising.

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

Once installed this extension allows you to add products to an RSS feed found at ```yourstoredomain.com/products.rss```, this can then be submitted to your Google Merchant Centre and Facebook Catalog accounts.


### Enhanced Listings

If you add a product with multiple variants to the feed, the extension will automatically recognise this, take each variant and create new feed item grouped under the master product id.

This is great for building Enhanced Listings on Google Shopping and works perfectly with Facebook Catalog.
![Google Merchant enhanced listing](https://lh3.googleusercontent.com/U52jfORqQSkO57TyGLFqdln08B7GnGYm5h0tyg91HxsN-4JoX7g2WR8CePG79udqEym1=w895)

## Adding Fields To Your Product Feed

To quickly add data to your product feed recommend using Product Properties and creating template through Prototypes.

### Creating A Prototype Template

- Form the admin panel visit **Properties** and click **New Property**.
- Add a new property using the following values: Name = ```g:google_product_category``` Presentation = ```product_feed_data```, click **Create**.
- Repeat the process above for ```g:brand```, ```g:product_type``` and any other properties you will use as standard for your products feed data.
- Next, visit the **Prototypes** menu and click **New Prototype**, in the properties section add your newly created properties, name it Default Feed Properties and click **Create**.
- Next, edit the product you want to add these to, click **Properties** from the sidebar menu, and then click add **Select From Pototype**.
- Select **Default Feed Properties** and add the desired values in each feild, then click **Update**.

You now have a custom made template for the stock Google Merchant Center product feed data.

### Adding Product Specific Data To Your Feed

If you have an item such as clothing that requires: ```<g:age_group>```, ```<g:gender>```, ```<g:material>``` into your products feed, you can add these as follows:

In the example below we are adding ```<g:gender>female</g:gender>``` to your products feed data.
- Form the admin panel visit **Properties** settings and click **New Property**.
- Add a new property using the following values: Name = ```g:gender``` Presentation = ```product_feed_data```, click **Create**.
- Next, edit your product and click the **Properties** tab form the sidebar options.
- Add a new property by typing **g:gender** in the property field, this will search for your newly created propery, select the proertys when it appears in the list, and then enter the value ```female``` and click **update**.

### Overiding the Default Title and Description

By default this extension will use your product name for the ```<g:title>``` field, and the meta description for the ```<g:description>``` field.

If you wish to override these, you can easily do so by adding product the properties ```<g:title>``` and ```<g:description>``` and setting the Presentations = ```product_feed_data```, as described above.


**NOTES:** There are a few things to keep in mind when adding data to your feed using product properties.
- Make sure to use the **g:** notation for the property name.
- Ideally, you will want to un-check the **SHOW PROPERTY** option so that this property is not visable on your store front (Spree 4.x).
- Any data entered using properties should apply to all variants (options) of this product.

## Unique Identifiers
You will notice that you now have an option to add a unique identifier to the master product and its variants.

It is a minimum requirement for most products passed into Google Merchant Center to have a Barcode (GTIN), or a Manufactures Part Number (MPN), you can also set the type of unique identifier that you prefer to use, in the product and variant settings.

## ToDo's
- Add in sale price logic when this is part of the spree core.
- Write spec tests.

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
