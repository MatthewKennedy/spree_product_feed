require "spec_helper"

describe "Tests A Product With Variants Added To The Feed", type: :feature, js: true do
  stub_authorization!

  let(:product) do
    FactoryBot.create(:base_product,
      name: "Mens Spree Logo Socks",
      meta_description: "A pair of mens socks in black with Spree logo.",
      feed_active: true,
      unique_identifier: "80250-95240",
      unique_identifier_type: "mpn")
  end

  let(:option_type) { create(:option_type) }
  let(:option_value1) { create(:option_value, name: "small", presentation: "S", option_type: option_type) }
  let(:option_value2) { create(:option_value, name: "medium", presentation: "M", option_type: option_type) }
  let(:option_value3) { create(:option_value, name: "large", presentation: "L", option_type: option_type) }
  let(:variant1) { create(:variant, product: product, option_values: [option_value1], price: "49.99", unique_identifier: "ver1-1", unique_identifier_type: "mpn") }
  let(:variant2) { create(:variant, product: product, option_values: [option_value2], price: "69.99", unique_identifier: "ver1-2", unique_identifier_type: "mpn", show_in_product_feed: false) }
  let(:variant3) { create(:variant, product: product, option_values: [option_value3], price: "50.00", unique_identifier: "ver1-3", unique_identifier_type: "mpn") }

  context "When a product with variants is set to be shown in the product feed" do
    before do
      product.option_types << option_type
      product.variants << [variant1, variant2, variant3]
      product.tap(&:save)

      visit "/products.rss"
    end

    it "it adds the variant id's correctly" do
      expect(page.body).to have_text("<g:id>1-1-2</g:id>")
      expect(page.body).to have_text("<g:id>1-1-4</g:id>")
    end

    it "it adds each variant unique_identifier and unique_identifier_type correctly" do
      expect(page.body).to have_text("<g:mpn>ver1-1</g:mpn>")
      expect(page.body).to have_text("<g:mpn>ver1-3</g:mpn>")
    end

    it "it sets the correct item_group_id for the varinats" do
      expect(page.body).to have_text("<g:item_group_id>1-1</g:item_group_id>")
    end

    it "it removes the variant that is not to be shown in the product feed" do
      expect(page.body).to_not have_text("<g:id>1-1-3</g:id>")
      expect(page.body).to_not have_text("<g:mpn>ver1-2</g:mpn>")
    end

    it "it removes the variant that is not to be shown in the product feed" do
      expect(page.body).to_not have_text("<g:id>1-1-3</g:id>")
      expect(page.body).to_not have_text("<g:mpn>ver1-2</g:mpn>")
    end
  end

  context "Testing the compare price" do
    it "sets the sale price if the compare price is higher than selling price" do
      price3 = Spree::Price.find_by(variant: variant3)
      price3.update(compare_at_amount: "80.00")
      price3.save

      product.option_types << option_type
      product.variants << [variant1, variant2, variant3]
      product.tap(&:save)

      visit "/products.rss"

      expect(page.body).to have_text("<g:price>80.0 USD</g:price>")
      expect(page.body).to have_text("<g:sale_price>50.0 USD</g:sale_price>")
    end

    it "does not set the sale price if the compare price is lower than selling price" do
      price3 = Spree::Price.find_by(variant: variant3)
      price3.update(compare_at_amount: "10")
      price3.save

      product.option_types << option_type
      product.variants << [variant1, variant2, variant3]
      product.tap(&:save)

      visit "/products.rss"

      expect(page.body).to have_text("<g:price>50.0 USD</g:price>")
      expect(page.body).not_to have_text("<g:sale_price>80.0 USD</g:sale_price>")
    end

    it "does not set the sale price if the compare price is nil" do
      price3 = Spree::Price.find_by(variant: variant3)
      price3.update(compare_at_amount: nil)
      price3.save

      product.option_types << option_type
      product.variants << [variant1, variant2, variant3]
      product.tap(&:save)

      visit "/products.rss"

      expect(page.body).to have_text("<g:price>50.0 USD</g:price>")
      expect(page.body).not_to have_text("<g:sale_price>80.0 USD</g:sale_price>")
    end
  end

  context "Testing variant availibilty" do
    it "shows OUT OF STOCK when count on hand is 0 and backorderable is false" do
      product.option_types << option_type
      product.variants << [variant1, variant2, variant3]

      product.variants_including_master.each { |v| v.stock_items.update_all count_on_hand: 0, backorderable: false }
      product.tap(&:save)

      visit "/products.rss"

      expect(page.body).to have_text("<g:availability>out of stock</g:availability>")
    end

    it "shows OUT OF STOCK when count on hand is 0 and backorderable is true" do
      product.option_types << option_type
      product.variants << [variant1, variant2, variant3]

      product.variants_including_master.each { |v| v.stock_items.update_all count_on_hand: 0, backorderable: true }
      product.tap(&:save)

      visit "/products.rss"

      expect(page.body).to have_text("<g:availability>out of stock</g:availability>")
    end

    it "shows IN STOCK when count on hand is 3 and backorderable is true" do
      product.option_types << option_type
      product.variants << [variant1, variant2, variant3]

      product.variants_including_master.each { |v| v.stock_items.update_all count_on_hand: 3, backorderable: true }
      product.tap(&:save)

      visit "/products.rss"

      expect(page.body).to have_text("<g:availability>in stock</g:availability>")
    end

    it "shows IN STOCK when count on hand is 3 and backorderable is false" do
      product.option_types << option_type
      product.variants << [variant1, variant2, variant3]

      product.variants_including_master.each { |v| v.stock_items.update_all count_on_hand: 3, backorderable: false }
      product.tap(&:save)

      visit "/products.rss"

      expect(page.body).to have_text("<g:availability>in stock</g:availability>")
    end
  end

  context "When a property is set with g:title and g:description" do
    let(:property) { create(:property) }
    let(:prop1) { create(:property, name: "g:title", presentation: "product_feed") }
    let(:prop2) { create(:property, name: "g:description", presentation: "product_feed") }

    it "the default title and description are removed from the feed, and the new values set" do
      product.update(properties: [prop1, prop2])
      product.product_properties.first.update(value: "THIS IS THE NEW TITLE")
      product.product_properties.last.update(value: "THIS IS THE NEW DESCRIPTION")

      visit "/products.rss"

      expect(page.body).not_to have_text("<g:title>Mens Spree Logo Socks</g:title>")
      expect(page.body).to have_text("<g:title>THIS IS THE NEW TITLE</g:title>")
      expect(page.body).not_to have_text("<g:description>A pair of mens socks in black with Spree logo.</g:description>")
      expect(page.body).to have_text("<g:description>THIS IS THE NEW DESCRIPTION</g:description>")
    end
  end
end
