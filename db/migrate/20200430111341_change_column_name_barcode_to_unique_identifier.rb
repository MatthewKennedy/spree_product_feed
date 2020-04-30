class ChangeColumnNameBarcodeToUniqueIdentifier < ActiveRecord::Migration[6.0]
  def change
    rename_column :spree_products, :barcode, :unique_identifier
    rename_column :spree_variants, :barcode, :unique_identifier
  end
end
