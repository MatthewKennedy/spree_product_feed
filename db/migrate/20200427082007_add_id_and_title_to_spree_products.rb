class AddIdAndTitleToSpreeProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_products, :product_feed_identification, :string
    add_column :spree_products, :product_feed_title, :string
  end
end
