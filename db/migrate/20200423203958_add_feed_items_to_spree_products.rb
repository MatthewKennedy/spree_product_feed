class AddFeedItemsToSpreeProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_products, :barcode, :string
    add_column :spree_products, :product_feed_title, :string
    add_column :spree_products, :product_feed_description, :text, limit: nil
    add_column :spree_products, :product_feed_condition, :string
    add_column :spree_products, :product_feed_product_type, :string
    add_column :spree_products, :product_feed_product_category, :string
    add_column :spree_products, :product_feed_active, :boolean, default: false
  end
end
