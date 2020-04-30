used_variants_options(product.variants, product).each do |option_type|
    option_type[:option_values].each do |option_value|
      if option_value[:variant_id] == variant.id
        xml.tag!('g:' + option_type[:presentation].downcase, option_value[:presentation])
      end
    end
end
