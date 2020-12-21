# spree_product_feed

![CI](https://github.com/MatthewKennedy/spree_product_feed/workflows/CI/badge.svg)
![Standard Rb](https://github.com/MatthewKennedy/spree_product_feed/workflows/Standard%20Rb/badge.svg)

The spree_product_feed extension allows you to connect your Spree store directly to Google Merchant Center and Facebook Catalog via a live RSS feed.

Additionally, your products can then be exported from Google Merchant Center across to Microsoft Merchant Center, giving you access to Bing Shopping, Yahoo Shopping and other partners of Microsoft Advertising.

### Enhanced Listings Ready

Spree Product Feed extension will automatically recognise a product with variants, take each variant and create new feed item grouped under the master product id, this is great for building **Enhanced Listings** on Google Shopping and works perfectly with Facebook Catalog.

### Sale Price Built In

You can take full advantage of the sale price (compare_at_price) functionality built into Spree 4.2 creating sale offers on your Google Shopping listings.

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

## Usage

### Adding Products To Your Feed
Once the extension is installed, you will notice a new checkbox (**Add to product feed**) available in the **Edit Product / Details** section.

When the **Add to product feed** checkbox is checked, your product or its variants depending on the type of product, will be added to the RSS feed located at: ```yourstoredomain.com/products.rss```, this can then be submitted to your Google Merchant Centre and Facebook Catalog accounts.

**NOTE:** You can hide specific variants by unchecking the **Show this varaint in product feed** within the edit details of each variant.

### Adding Data To The Products In Your Feed

To add data to each item in your feed this extension takes full advantage of **Product Properties**. In the example below we are adding ```<g:gender>female</g:gender>``` to a product.

- Form the admin panel visit **Properties** settings and click **New Property**.
- Add a new property using the following values: Name = ```g:gender``` Presentation = ```product_feed```, click **Create**.
- Next, edit your product and click the **Properties** tab form the sidebar options.
- Add a new property by typing **g:** in the property field, this will search for your newly created property, select the property when it appears in the list, and then enter the value ```female``` and click **update**.

To increase productivity it is wise to create ```g:google_product_category```, ```g:condition```, ```g:brand```, ```g:product_type```, and then set these as a  **Prototype** for fast repeated use.

### Overriding The Default Title & Description

By default, this extension will use your product name for the ```<g:title>``` field, and the meta description for the ```<g:description>``` field.

If you wish to override these, you can easily do so by adding product properties ```<g:title>``` and ```<g:description>``` with the Presentations = ```product_feed```, as described above.

## Unique Identifiers
You will notice that you now have an option to add a unique identifier to the master product and its variants.

It is a minimum requirement for most products passed into Google Merchant Center to have a Barcode (GTIN), or a Manufactures Part Number (MPN), you can also set the type of unique identifier that you prefer to use, in the product and variant settings.

## Feed Examples

To view your feed as you build it, visit:  ```localhost:3000/products.rss``` in Chrome, (you may need to clear browser cache to see your changes).

```xml
<!-- The first example is a variant with a sale price set using compare_at_price -->
<item>
  <!-- Item id is created using -->
  <!-- store.id - master product.id - variant.id -->
  <g:id>1-13-14</g:id>

  <!-- Title and description can be overridden if needed -->
  <g:title>Spree Cotton T-Shirt</g:title>
  <g:description>Spree logo mens T-Shirt made from 100% cotton.</g:description>

  <!-- Automatically generated from product or variant data  -->
  <g:link>https://yourstore.com/products/mens-cotton-t-shirt?variant=14</g:link>
  <g:image_link>https://yourstore.com/rails/active_storage/blobs/isdh988/spree-t-shirt-red.jpg</g:image_link>
  <g:availability>in stock</g:availability>

  <!-- Sale price data  -->
  <g:price>25.0 GBP</g:price>
  <g:sale_price>22.25 GBP</g:sale_price>

  <!-- Unique Identifiers  -->
  <g:gtin>3090364680183</g:gtin>
  <g:sku>SPREE-T-RED-S</g:sku>

  <!-- Automatically generated through Variant Options  -->
  <g:size>S</g:size>
  <g:color>red</g:color>

  <!-- Variants are given an item_group_id as follows -->
  <!-- store.id - master product.id -->
  <g:item_group_id>1-13</g:item_group_id>

  <!-- Created manually using Properties -->
  <g:product_type>Apparel &amp; Accessories &gt; Clothing &gt; Shirts &amp; Tops</g:product_type>
  <g:google_product_category>Apparel &amp; Accessories &gt; Clothing &gt; Shirts &amp; Tops</g:google_product_category>
  <g:brand>Spree Brand</g:brand>
  <g:gender>male</g:gender>
  <g:condition>new</g:condition>
  <g:age_group>adult</g:age_group>
  <g:material>cotton</g:material>
</item>

<!-- The second example is a basic product with no variants, no sale price -->
<!-- but the title and description have been manually set using Properties  -->
<item>
  <!-- Item id is created using -->
  <!-- store.id - master product.id-->
  <g:id>1-11</g:id>

  <!-- Automatically generated from product data  -->
  <g:link>https://yourstore.com/products/mug</g:link>
  <g:image_link>https://yourstore.com/rails/active_storage/blobs/isdh988/spree-mug.jpg</g:image_link>
  <g:availability>in stock</g:availability>
  <g:price>6.99 GBP</g:price>
  <g:gtin>4095364423100</g:gtin>
  <g:sku>SPREE-MUG</g:sku>

  <!-- Created manually using Properties -->
  <g:title>Spree Mug</g:title>
  <g:description>Spree mug with black logo and red base.</g:description>
  <g:product_type>Home &gt; Mugs &gt; Spree Mug</g:product_type>
  <g:google_product_category>22819</g:google_product_category>
  <g:brand>Spree</g:brand>
  <g:condition>new</g:condition>
</item>
 ```

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
