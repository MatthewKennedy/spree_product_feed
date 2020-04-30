xml.tag!('g:id', (current_store.url + '_product_' + product.default_variant.id.to_s + '_' + current_currency).downcase)
xml.tag!('g:title', product.product_feed_title? ? product.product_feed_title : product.name)
xml.tag!('g:description', product.product_feed_description? ? product.product_feed_description : product.meta_description)
xml.tag!('g:link', spree.product_url(product))
xml.tag!('g:image_link', structured_images(product))
xml.tag!('g:condition', product.product_feed_condition)
xml.tag!('g:availability', product.in_stock? ? 'in stock' : 'out of stock')
xml.tag!('g:price', product.default_variant.price_in(current_currency).amount.to_s + ' ' + current_currency)
if product.variants_and_option_values(current_currency).any?
    used_variants_options(product.variants, product).each do |option_type|
        option_type[:option_values].each do |option_value|
          if option_value[:variant_id] == product.default_variant[:id]
            xml.tag!('g:' + option_type[:presentation].downcase, option_value[:presentation])
          end
        end
    end
end
xml.tag!('g:item_group_id', (current_store.url + '_product_' + product.id.to_s + '_' + current_currency).downcase )
xml.tag!('g:' + structured_unique_identifier_type(product), structured_unique_identifier(product))
xml.tag!('g:brand', structured_brand(product))
xml.tag!('g:product_type', product.product_feed_product_type)
xml.tag!('g:google_product_category', product.product_feed_product_category)

unless product.product_properties.blank?
  xml << render(:partial => 'properties', :locals => { :product => product } )
end
