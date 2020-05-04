xml.tag!('g:id', (current_store.id.to_s + '-' + current_currency + '-' + product.default_variant.id.to_s).downcase)
xml.tag!('g:title', product.product_feed_title? ? product.product_feed_title : product.name)
xml.tag!('g:description', product.product_feed_description? ? product.product_feed_description : product.meta_description)
xml.tag!('g:link', spree.product_url(product))
xml.tag!('g:image_link', structured_images(product))
xml.tag!('g:condition', product.product_feed_condition)
xml.tag!('g:availability', product.in_stock? ? 'in stock' : 'out of stock')
xml.tag!('g:price', product.default_variant.price_in(current_currency).amount.to_s + ' ' + current_currency)
xml.tag!('g:' + structured_unique_identifier_type(product), structured_unique_identifier(product))
xml.tag!('g:brand', structured_brand(product))
xml.tag!('g:sku', structured_sku(product))
xml.tag!('g:product_type', product.product_feed_product_type)
xml.tag!('g:google_product_category', product.product_feed_product_category)

unless product.product_properties.blank?
  xml << render(:partial => 'properties', :locals => { :product => product } )
end
