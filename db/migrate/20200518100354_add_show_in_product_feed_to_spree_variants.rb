class AddShowInProductFeedToSpreeVariants < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_variants, :show_in_product_feed, :boolean, default: true
  end
end
