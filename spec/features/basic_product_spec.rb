require "spec_helper"

describe "Test A Product Without Variants In The Feed", type: :feature, js: true do
  stub_authorization!

  let(:product) do
    FactoryBot.create(:base_product,
      name: "Mens Spree Logo Socks",
      meta_description: "A pair of mens socks in black with Spree logo.",
      feed_active: true,
      unique_identifier: "80250-95240",
      unique_identifier_type: "mpn")
  end

  context "When feed_active is set to true, the product" do
    it "shows the xml item, id, name and description correctly in the feed" do
      product.tap(&:save)
      visit "/products.rss"

      expect(page.body).to have_text("<g:id>1-1</g:id>")
      expect(page.body).to have_text("<g:title>Mens Spree Logo Socks</g:title>")
      expect(page.body).to have_text("<g:description>A pair of mens socks in black with Spree logo.</g:description>")
    end
  end

  context "Check the unique identifier" do
    it "shows type GTIN with the correct barcode" do
      product.update(unique_identifier: "8025082379237", unique_identifier_type: "gtin")
      visit "/products.rss"

      expect(page.body).to have_text("<g:gtin>8025082379237</g:gtin>")
    end

    it "shows type MPN with the correct manufacturers part number" do
      product.update(unique_identifier: "MPN901222", unique_identifier_type: "mpn")
      visit "/products.rss"

      expect(page.body).to have_text("<g:mpn>MPN901222</g:mpn>")
    end
  end

  context "Make sure the product availability" do
    it "shows OUT OF STOCK when count on hand is 0 and backorderable is false" do
      product.master.stock_items.update_all count_on_hand: 0, backorderable: false
      visit "/products.rss"

      expect(page.body).to have_text("<g:availability>out of stock</g:availability>")
    end

    it "shows IN STOCK when count on hand is 3 and backorderable is true" do
      product.master.stock_items.update_all count_on_hand: 3, backorderable: true
      visit "/products.rss"

      expect(page.body).to have_text("<g:availability>in stock</g:availability>")
    end

    it "shows IN STOCK when count on hand is 3 and backorderable is false" do
      product.master.stock_items.update_all count_on_hand: 3, backorderable: false
      visit "/products.rss"

      expect(page.body).to have_text("<g:availability>in stock</g:availability>")
    end

    it "shows OUT OF STOCK when count on hand is 0 and backorderable is true" do
      product.master.stock_items.update_all count_on_hand: 0, backorderable: true
      visit "/products.rss"

      expect(page.body).to have_text("<g:availability>out of stock</g:availability>")
    end
  end

  context "When the product compare price is set it" do
    it "shows sale price if compare at price is higher than master price" do
      product.master.prices.first.update(compare_at_amount: 69.99)
      visit "/products.rss"

      expect(page.body).to have_text("<g:sale_price>19.99 USD</g:sale_price>")
      expect(page.body).to have_text("<g:price>69.99 USD</g:price>")
    end

    it "does not show a sale price if compare at price is less than selling price" do
      product.master.prices.first.update(compare_at_amount: 9.99)
      visit "/products.rss"

      expect(page.body).not_to have_text("<g:sale_price>9.99 USD</g:sale_price>")
      expect(page.body).to have_text("<g:price>19.99 USD</g:price>")
    end

    it "does not show a sale price if compare at price nil" do
      product.master.prices.first.update(compare_at_amount: nil)
      visit "/products.rss"

      expect(page.body).not_to have_text("<g:sale_price>9.99 USD</g:sale_price>")
      expect(page.body).to have_text("<g:price>19.99 USD</g:price>")
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
