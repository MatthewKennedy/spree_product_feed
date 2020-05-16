class AddFeedItemsToSpreeProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_products, :unique_identifier, :string
    add_column :spree_products, :unique_identifier_type, :string, default: 'gtin'
    add_column :spree_products, :product_feed_active, :boolean, default: false
  end
end
