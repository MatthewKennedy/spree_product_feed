require 'spec_helper'

describe 'Set store values in xml feed', type: :feature, js: true do
  stub_authorization!

  let(:store) { Spree::Store.default }

  context 'If no preferances are set' do

    it 'it renders the default store details correctly' do
      visit "/products.rss"
      
      expect(page.body).to have_text('<title>Spree Test Store</title>')
      expect(page.body).to have_text('<link>www.example.com</link>')
      expect(page.body).to have_text('<language>en-us</language>')
    end
  end

  context 'When custom properties are set' do
    before do
      store.update(url: 'www.therubberfactory.com', name: 'The Rubber Factory', default_locale: 'en-GB')
    end

    it 'the feed displays custom title, link and language' do
      visit "/products.rss"

      expect(page.body).to have_text('<title>The Rubber Factory</title>')
      expect(page.body).to have_text('<link>www.therubberfactory.com</link>')
      expect(page.body).to have_text('<language>en-gb</language>')
    end
  end
end
