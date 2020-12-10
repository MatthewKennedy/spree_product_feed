product.product_properties.each do |product_property|
  if product_property.property.presentation.downcase == "product_feed"
    xml.tag!(product_property.property.name.downcase, product_property.value)
  end
end
