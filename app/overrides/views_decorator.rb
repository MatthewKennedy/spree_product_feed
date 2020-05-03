Deface::Override.new(
  virtual_path: 'spree/admin/products/_form',
  name: 'add_barcode_to_product_form',
  insert_bottom: '[data-hook="admin_product_form_sku"]',
  partial: 'spree/admin/shared/product_unique_identifier'
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
  insert_bottom: '[data-hook="admin_variant_form_additional_fields"]',
  partial: 'spree/admin/shared/variant_unique_identifier'
)

Deface::Override.new(:virtual_path => 'layouts/spree_application',
                     :name => 'product_rss_link',
                     :original => '86987c7feaaea3181df195ca520571d801bbbaf3',
                     :insert_bottom => "[data-hook='inside_head']",
                     :text => '<%= auto_discovery_link_tag(:rss, products_path(:format => :rss), {:title => "#{Spree::Config[:site_title]} Products"}) %>')
