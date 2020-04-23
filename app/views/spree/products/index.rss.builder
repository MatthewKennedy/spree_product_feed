xml.instruct! :xml, :version=>"1.0"
xml.rss("xmlns:g" => "http://base.google.com/ns/1.0", :version=>"2.0"){
  xml.channel{
    xml.title(current_store.name)
    xml.link(current_store.url)
    xml.description("Find out about new products first! You'll always be in the know when new products become available")
    xml.language(I18n.locale)

    @products.each do |product|
      xml.item do
        xml.tag!('g:id', product.sku)
        xml.tag!('g:title', product.name)
        xml.tag!('g:meta_description', product.description)
        xml.tag!('g:link', spree.product_url(product))
        xml.tag!('g:image_link', structured_images(product))
        xml.tag!('g:availability', 'in stock')
        xml.tag!('g:price', product.price_in(current_currency).amount.to_s + ' ' + current_currency)

        #xml.tag!('g:condition', product.google_condition)
        #xml.tag!('g:gtin', product.gtin)
        #xml.tag!('g:brand', product.property.brand)
        #xml.tag!('g:sku', product.google_product_type)
      end
    end
  }
}
