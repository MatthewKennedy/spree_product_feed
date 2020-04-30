xml.tag!('g:id', (current_store.url + '_product_' + variant.id.to_s + '_' + current_currency).downcase)
xml.tag!('g:title', product.product_feed_title? ? product.product_feed_title : product.name)
xml.tag!('g:description', product.product_feed_description? ? product.product_feed_description : product.meta_description)
xml.tag!('g:link', spree.product_url(product))
xml.tag!('g:image_link', structured_images(variant))
xml.tag!('g:condition', product.product_feed_condition)
xml.tag!('g:availability', variant.in_stock? ? 'in stock' : 'out of stock')
xml.tag!('g:price', variant.price_in(current_currency).amount.to_s + ' ' + current_currency)
xml.tag!('g:' + variant.unique_identifier_type, variant.unique_identifier)
xml.tag!('g:brand', structured_brand(product))
xml.tag!('g:sku', variant.sku)
xml.tag!('g:product_type', product.product_feed_product_type)
xml.tag!('g:google_product_category', product.product_feed_product_category)
xml.tag!('g:item_group_id', (current_store.url + '_product_' + product.default_variant.id.to_s + '_' + current_currency).downcase)

xml << render(:partial => 'options', :locals => { :product => product, :variant => variant } )

unless product.product_properties.blank?
  xml << render(:partial => 'properties', :locals => { :product => product } )
end
