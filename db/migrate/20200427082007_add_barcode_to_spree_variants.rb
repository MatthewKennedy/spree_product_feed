class AddBarcodeToSpreeVariants < ActiveRecord::Migration[6.0]
  def change
    add_column :spree_variants, :barcode, :string
  end
end
