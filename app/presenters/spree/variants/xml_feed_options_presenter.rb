module Spree
  module Variants
    class XmlFeedOptionsPresenter
      attr_reader :variant

      delegate :option_values, to: :variant

      def initialize(variant)
        @variant = variant
      end

      def xml_options
        options = option_values
        options = sort_options(options)
        options = present_options(options)
      end

      def xml_url_option
        options = option_values
        options = sort_opts(options)
        options = present_options_for_url(options)

        join_options(options)
      end

      private

      def sort_options(options)
        options.sort_by { |o| o.option_type.position }
      end

      def sort_opts(options)
        options.sort_by { |o| o.option_type.id }
      end

      def present_options(options)
        options.map do |ov|
          method = "present_#{ov.option_type.name}_option"

          respond_to?(method, true) ? send(method, ov) : present_option(ov)
        end
      end

      def present_options_for_url(options)
        options.map do |ov|
          method = "present_#{ov.option_type.name}_option"

          respond_to?(method, true) ? send(method, ov) : present_url_option(ov)
        end
      end

      def present_option(option)
        option
      end

      def present_url_option(option)
        "#{option.option_type.name.downcase}=#{option.option_type.id}_#{option.id}"
      end

      def join_options(options)
        options.join("&")
      end
      
    end
  end
end
