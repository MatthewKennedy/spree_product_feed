xml.tag!('g:id', (current_store.id.to_s + '-' + current_currency + '-' + product.default_variant.id.to_s).downcase)

unless product.property('g:title').present?
  xml.tag!('g:title', product.name)
end
unless product.property('g:description').present?
  xml.tag!('g:description', product.meta_description)
end

xml.tag!('g:link', spree.product_url(product))
xml.tag!('g:image_link', structured_images(product))
xml.tag!('g:availability', product.in_stock? ? 'in stock' : 'out of stock')
xml.tag!('g:price', product.default_variant.price_in(current_currency).amount.to_s + ' ' + current_currency)
xml.tag!('g:' + structured_unique_identifier_type(product), structured_unique_identifier(product))
xml.tag!('g:sku', structured_sku(product))

unless product.product_properties.blank?
  xml << render(:partial => 'props', :locals => { :product => product } )
end
