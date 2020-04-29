Deface::Override.new(
  virtual_path: 'spree/admin/products/_form',
  name: 'add_barcode_to_product_form',
  insert_bottom: '[data-hook="admin_product_form_sku"]',
  partial: 'spree/admin/shared/product_barcode'
)

Deface::Override.new(
  virtual_path: 'spree/admin/products/_form',
  name: 'add_product_branding_url_to_product_form',
  insert_bottom: '[data-hook="admin_product_form_additional_fields"]',
  partial: 'spree/admin/shared/product_feed_form'
)

Deface::Override.new(
  virtual_path: 'spree/admin/variants/_form',
  name: 'add_barcode_to_product_form',
  insert_bottom: '[data-hook="sku"]',
  partial: 'spree/admin/shared/variant_barcode'
)
