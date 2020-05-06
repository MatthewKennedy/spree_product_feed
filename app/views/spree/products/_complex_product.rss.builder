xml.tag!('g:id', (current_store.id.to_s + '-' + current_currency + '-' + product.id.to_s + '-' + variant.id.to_s).downcase)
xml.tag!('g:title', product.product_feed_title? ? product.product_feed_title : product.name)
xml.tag!('g:description', product.product_feed_description? ? product.product_feed_description : product.meta_description)
xml.tag!('g:link', spree.product_url(product) + '?variant=' +  variant.id.to_s)
xml.tag!('g:image_link', structured_images(variant))
xml.tag!('g:condition', product.product_feed_condition)
xml.tag!('g:availability', variant.in_stock? ? 'in stock' : 'out of stock')
xml.tag!('g:price', variant.price_in(current_currency).amount.to_s + ' ' + current_currency)
xml.tag!('g:' + variant.unique_identifier_type, variant.unique_identifier)
xml.tag!('g:brand', structured_brand(product))
xml.tag!('g:sku', variant.sku)
xml.tag!('g:product_type', product.product_feed_product_type)
xml.tag!('g:google_product_category', product.product_feed_product_category)
xml.tag!('g:item_group_id', (current_store.id.to_s + '-' + current_currency + '-' + product.id.to_s).downcase )

options_xml_hash = Spree::Variants::XmlFeedOptionsPresenter.new(variant).xml_options
options_xml_hash.each do |ops|
  xml.tag!('g:'+ ops.option_type.presentation.downcase , ops.presentation.downcase)
end

unless product.product_properties.blank?
  xml << render(:partial => 'props', :locals => { :product => product } )
end
