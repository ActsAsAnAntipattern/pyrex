module Pyrex
  class ParamValidator
    class << self
      def validate_params signature, code_to_execute, provided_arguments
        # Calling `parameters` on a block will return
        #   [['opt', 'first_arg_keyword'], ['opt', 'second_arg_keyword']]
        provided_param_keywords = code_to_execute.parameters

        # parameter_type can be `opt`, `key` or `keyreq`
        provided_param_keywords.each_with_index do |(param_type, param_keyword), index|
          argument_value = provided_arguments[index]
          validate_argument(signature, param_type, param_keyword, argument_value)
        end

        return true
      end

      def validate_argument(signature, param_type, param_keyword, argument_value)
        argument_value = (argument_value[param_keyword] rescue nil) if [:key, :keyreq].include?(param_type)

        if !signature.valid_param?(param_keyword, argument_value.class)
          raise Pyrex::Errors::InvalidArgumentType.new(
            signature: signature, 
            param_keyword: param_keyword,
            given_type: argument_value.class
          )
        end
      end
    end
  end
end
