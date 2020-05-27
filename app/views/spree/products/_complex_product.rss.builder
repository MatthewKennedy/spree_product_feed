xml.tag!('g:id', (current_store.id.to_s + '-' + product.id.to_s + '-' + variant.id.to_s).downcase)

unless product.property('g:title').present?
  xml.tag!('g:title', product.name)
end

unless product.property('g:description').present?
  xml.tag!('g:description', product.meta_description)
end

xml.tag!('g:link', spree.product_url(product) + '?variant=' +  variant.id.to_s)
xml.tag!('g:image_link', structured_images(variant))
xml.tag!('g:availability', variant.in_stock? ? 'in stock' : 'out of stock')

if defined?(variant.compare_at_price) && variant.compare_at_price != nil
  if variant.compare_at_price > product.price
    xml.tag!('g:price', variant.compare_at_price.to_s + ' ' + current_currency)
    xml.tag!('g:sale_price', variant.price_in(current_currency).amount.to_s + ' ' + current_currency)
  else
    xml.tag!('g:price', variant.price_in(current_currency).amount.to_s + ' ' + current_currency)
  end
else
  xml.tag!('g:price', variant.price_in(current_currency).amount.to_s + ' ' + current_currency)
end

xml.tag!('g:' + variant.unique_identifier_type, variant.unique_identifier)
xml.tag!('g:sku', variant.sku)
xml.tag!('g:item_group_id', (current_store.id.to_s + '-' + product.id.to_s).downcase)

options_xml_hash = Spree::Variants::XmlFeedOptionsPresenter.new(variant).xml_options
options_xml_hash.each do |ops|
  if ops.option_type[:name] == "color"
    xml.tag!('g:'+ ops.option_type.presentation.downcase , ops.name)
  else
    xml.tag!('g:'+ ops.option_type.presentation.downcase , ops.presentation)
  end
end

unless product.product_properties.blank?
  xml << render(:partial => 'props', :locals => { :product => product })
end
