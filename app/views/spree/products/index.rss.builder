xml.instruct! :xml, :version=>"1.0"
xml.rss("xmlns:g" => "http://base.google.com/ns/1.0", :version=>"2.0"){
  xml.channel{
    xml.title(current_store.name)
    xml.link(current_store.url)
    xml.description("Find out about new products first! You'll always be in the know when new products become available")
    xml.language(I18n.locale)

    @products.each do |product|
      if product.product_feed_active
        xml.item do
          xml.tag!('g:id', product.product_feed_identification? ? product.product_feed_identification : product.sku)
          xml.tag!('g:title', product.product_feed_title? ? product.product_feed_title : product.name)
          xml.tag!('g:description', product.product_feed_description? ? product.product_feed_description : product.meta_description)
          xml.tag!('g:link', spree.product_url(product))
          xml.tag!('g:image_link', structured_images(product))
          if product.variants_and_option_values(current_currency).any?
              used_variants_options(product.variants, product).each do |option_type|
                  option_type[:option_values].each do |option_value|
                    if option_value[:variant_id] == product.default_variant[:id]
                      xml.tag!('g:' + option_type[:presentation].downcase, option_value[:presentation])
                    end
                  end
              end
          end
        if product.default_variant.in_stock?
          xml.tag!('g:availability', 'in stock')
        elsif product.default_variant.backorderable?
          xml.tag!('g:availability', 'in stock')
        else
          xml.tag!('g:availability', 'out of stock')
        end
          xml.tag!('g:price', product.price_in(current_currency).amount.to_s + ' ' + current_currency)
          xml.tag!('g:condition', product.product_feed_condition)
          xml.tag!('g:gtin', product.product_feed_gtin)
          xml.tag!('g:brand', product.product_feed_brand)
          xml.tag!('g:mpn', product.product_feed_mpn? ? product.product_feed_mpn : product.sku)
          xml.tag!('g:product_type', product.product_feed_product_type)
          xml.tag!('g:google_product_category', product.product_feed_product_category)
        end
      end
    end
  }
}
