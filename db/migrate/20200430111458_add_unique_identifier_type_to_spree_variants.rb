class AddUniqueIdentifierTypeToSpreeVariants < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_variants, :unique_identifier_type, :string, default: 'gtin'
  end
end
