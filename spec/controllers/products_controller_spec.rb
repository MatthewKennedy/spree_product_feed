require 'spec_helper'

describe Spree::ProductsController, type: :controller do
  context 'When the index action is called with the format set to RSS' do
    it "it returns with type application/rss+xml; charset=utf-8 & response :ok" do
      get :index, :format => "rss"

      expect(response.content_type).to eq("application/rss+xml; charset=utf-8")
      expect(response).to have_http_status(:ok)
    end
  end
end
