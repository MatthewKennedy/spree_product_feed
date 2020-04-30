class AddUniqueIdentifierTypeToSpreeProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_products, :unique_identifier_type, :string
  end
end
