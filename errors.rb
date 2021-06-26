module Pyrex
  module Errors
    class PreventDefUsage < StandardError
      def initialize message: nil, method_name: 
        message ||= "You tried to define a method \"#{method_name}\" using def instead of pdef in a pyrex class. Prefix your method with __ if you would like to wreak havoc."
        super(message)
      end
    end

    class InvalidArgumentType < StandardError
      def initialize message: nil, signature:, param_keyword:, given_type:
        expected_type = signature.expected_types(param_keyword)
        message ||= "Invalid argument type given to #{signature.name}. \"#{param_keyword}\" expected to be of type(s) #{expected_type}, given #{given_type}"
        super(message)
      end
    end

    class InvalidReturnType < StandardError
      def initialize message: nil, signature:, given_type:
        expected_type = signature.returns
        message ||= "Invalid type returned from #{signature.name}. Return value expected to be of type(s) #{expected_type}, given #{given_type}"
        super(message)
      end
    end
  end
end
