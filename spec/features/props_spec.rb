require 'spec_helper'

describe 'Tests Product Properties', type: :feature, js: true do
  stub_authorization!

  context 'A product property with presentation set to' do
    let(:property) { create(:property) }
    let(:prop1) { create(:property, name: 'g:product_type', presentation: 'product_feed') }
    let(:prop2) { create(:property, name: 'Product Brand', presentation: 'product_brand') }
    let(:product) { create(:product, properties: [prop1, prop2], price: '49.99', feed_active: true, unique_identifier: '80250-95240', unique_identifier_type: 'mpn' ) }

    before do
      product.tap(&:save)
      product.product_properties.first.update(value: 'Mens Baggy Socks')
      product.product_properties.last.update(value: 'Spree Brand')
      visit "/products.rss"
    end

    it "product_feed shows the correct xml tag name and value in feed" do
      expect(page.body).to have_text('<g:product_type>Mens Baggy Socks</g:product_type>')
    end

    it "any other value does not show in the feed" do
      expect(page.body).not_to have_text('<Product Brand>Spree Brand</Product Brand>')
    end
  end
end
