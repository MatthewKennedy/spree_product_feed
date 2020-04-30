xml.instruct! :xml, :version=>"1.0"
xml.rss("xmlns:g" => "http://base.google.com/ns/1.0", :version=>"2.0"){
  xml.channel{
    xml.title(current_store.name)
    xml.link(current_store.url)
    xml.description("Find out about new products first! You'll always be in the know when new products become available")
    xml.language(I18n.locale)

    @products.each do |product|

      if product.product_feed_active
          if product.variants_and_option_values(current_currency).any?
            product.variants.each do |variant|
              xml.item do
                xml << render(:partial => 'complex_product', :locals => { :product => product, :variant => variant } ).gsub(/^/, '      ')
              end
            end
          else
            xml.item do
              xml << render(:partial => 'basic_product', :locals => { :product => product } ).gsub(/^/, '      ')
            end
          end
      end

    end
  }
}
