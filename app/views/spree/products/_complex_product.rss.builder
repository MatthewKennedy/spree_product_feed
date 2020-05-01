xml.tag!('g:id', (current_currency + '-' + product.sku).upcase)
xml.tag!('g:title', product.product_feed_title? ? product.product_feed_title : product.name)
xml.tag!('g:description', product.product_feed_description? ? product.product_feed_description : product.meta_description)
xml.tag!('g:link', spree.product_url(product))
xml.tag!('g:image_link', structured_images(variant))
xml.tag!('g:condition', product.product_feed_condition)
xml.tag!('g:availability', variant.in_stock? ? 'in stock' : 'out of stock')
xml.tag!('g:price', variant.price_in(current_currency).amount.to_s + ' ' + current_currency)
xml.tag!('g:' + variant.unique_identifier_type, variant.unique_identifier)
xml.tag!('g:brand', structured_brand(product))
xml.tag!('g:sku', (product.sku + '-' + variant.sku).upcase)
xml.tag!('g:product_type', product.product_feed_product_type)
xml.tag!('g:google_product_category', product.product_feed_product_category)
xml.tag!('g:item_group_id', (current_currency + '-' + product.sku).upcase + '-' + variant.id.to_s)

options_xml_hash = Spree::Variants::FeedOptionsPresenter.new(variant).xml_options

options_xml_hash.each do |o|
  xml.tag!('g:'+ o.option_type.presentation.downcase , o.presentation.downcase)
end

unless product.product_properties.blank?
  xml << render(:partial => 'properties', :locals => { :product => product } )
end
