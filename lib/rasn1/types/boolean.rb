# frozen_string_literal: true

module RASN1
  module Types
    # ASN.1 Boolean
    # @author Sylvain Daubert
    class Boolean < Primitive
      TAG = 0x01

      private

      def value_to_der
        [@value ? 0xff : 0x00].pack('C')
      end

      def der_to_value(der, ber: false)
        raise ASN1Error, "tag #{@name}: BOOLEAN should have a length of 1" unless der.size == 1

        bool = der.unpack('C').first
        case bool
        when 0
          @value = false
        when 0xff
          @value = true
        else
          raise ASN1Error, "tag #{@name}: bad value 0x%02x for BOOLEAN" % bool unless ber

          @value = true
        end
      end
    end
  end
end
