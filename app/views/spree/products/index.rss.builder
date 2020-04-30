xml.instruct! :xml, :version=>"1.0"
xml.rss("xmlns:g" => "http://base.google.com/ns/1.0", :version=>"2.0"){
  xml.channel{
    xml.title(current_store.name)
    xml.link(current_store.url)
    xml.description("Find out about new products first! You'll always be in the know when new products become available")
    xml.language(I18n.locale)

    @products.each do |product|
      if product.product_feed_active
        xml.item do

          if product.variants_and_option_values(current_currency).any?
            xml << render(:partial => 'complex_product', :locals => { :product => product } ).gsub(/^/, '      ')
          else
            xml << render(:partial => 'basic_product', :locals => { :product => product } ).gsub(/^/, '      ')
          end
          
        end
      end
    end
  }
}
