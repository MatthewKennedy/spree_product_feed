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
          xml.tag!('g:id', product.sku)
          xml.tag!('g:title', product.name)
          xml.tag!('g:meta_description', product.product_feed_description)
          xml.tag!('g:link', spree.product_url(product))
          xml.tag!('g:image_link', structured_images(product))
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
          xml.tag!('g:mpn', product.product_feed_mpn)
          xml.tag!('g:brand', product.product_feed_brand)
          xml.tag!('g:product_type', product.product_feed_product_type)
          xml.tag!('g:google_product_category', product.product_feed_product_category)
        end
      end
    end
  }
}
