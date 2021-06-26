require_relative 'param_validator'

module Pyrex
  class Signature
    attr_accessor :name, :returns, :params

    def initialize(name:, returns:, params:)
      @name = name
      @returns = returns
      @params = params
    end

    def valid_return?(return_value)
      valid_type = Array(returns).include?(return_value.class)
      raise Pyrex::Errors::InvalidReturnType.new(signature: self, given_type: return_value.class) unless valid_type
    end

    def valid_param?(param_name, argument_value_class)
      permitted_types = expected_types(param_name) 
      permitted_types.include?(argument_value_class)
    end

    def expected_types(param_name)
      Array(@params[param_name.to_sym])
    end

    class << self 
      def build(method_signature)
        method_name          = method_signature.keys.first
        expected_return_type = method_signature.delete(method_name)[:returns]

        new(
          name: method_name,
          returns: expected_return_type,
          params: method_signature,
        )
      end
    end
  end
end
