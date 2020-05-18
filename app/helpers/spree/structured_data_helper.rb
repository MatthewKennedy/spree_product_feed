module Spree
  module StructuredDataHelper
    def products_structured_data(products)
      content_tag :script, id: 'productStructuredData', type: 'application/ld+json' do
        raw(
          products.map do |product|
            structured_product_hash(product)
          end.to_json
        )
      end
    end

    private

    def structured_product_hash(product)
      Rails.cache.fetch(common_product_cache_keys + ["spree/structured-data/#{product.cache_key_with_version}"]) do
        {
          '@context': 'https://schema.org/',
          '@type': 'Product',
          name: product.name,
          image: structured_images(product),
          description: product.description,
          sku: structured_sku(product),
          brand: {
            '@type': 'Brand',
            name: structured_brand(product)
          },
          offers: {
            '@type': 'Offer',
            url: spree.product_url(product),
            price: product.default_variant.price_in(current_currency).amount,
            priceCurrency: current_currency,
            itemCondition: structured_condition(product),
            availability: product.in_stock? ? 'https://schema.org/InStock' : 'https://schema.org/OutOfStock',
            availabilityEnds: product.discontinue_on ? product.discontinue_on.strftime('%F') : '',
            seller: {
              '@type': 'Organization',
              name: current_store.name
            }
          }
        }
      end
    end

    def structured_sku(product)
      product.default_variant.sku? ? product.default_variant.sku : product.sku
    end

    def structured_condition(product)
      return '' unless product.property('g:condition').present?

      if product.property('g:condition') == 'used'
        'https://schema.org/UsedCondition'
      elsif product.property('g:condition') == 'new'
        'https://schema.org/NewCondition'
      end
    end

    def structured_unique_identifier(product)
      product.default_variant.unique_identifier? ? product.default_variant.unique_identifier : product.unique_identifier
    end

    def structured_unique_identifier_type(product)
      product.default_variant.unique_identifier_type ? product.default_variant.unique_identifier_type : product.unique_identifier_type
    end

    def structured_brand(product)
      return '' unless product.property('g:brand').present?

      product.property('g:brand')
    end

    def structured_images(product)
      image = default_image_for_product_or_variant(product)

      return '' unless image

      main_app.rails_blob_url(image.attachment)
    end
  end
end
