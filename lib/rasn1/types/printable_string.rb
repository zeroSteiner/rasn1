# frozen_string_literal: true

module RASN1
  module Types
    # ASN.1 Printable String
    # @author Sylvain Daubert
    class PrintableString < OctetString
      # PrintableString tag value
      TAG = 19

      # Get ASN.1 type
      # @return [String]
      def self.type
        'PrintableString'
      end

      private

      def value_to_der
        check_characters
        @value.to_s.force_encoding('BINARY')
      end

      def der_to_value(der, ber: false)
        super
        check_characters
      end

      def check_characters
        raise ASN1Error, "PRINTABLE STRING #{@name}: invalid character: '#{$1}'" if @value.to_s =~ %r{([^a-zA-Z0-9 '=\(\)\+,\-\.\/:\?])}
      end
    end
  end
end
