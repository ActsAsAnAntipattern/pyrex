module Pyrex
  class Method
    def self.define_method_for_class(klass, signature, block)
      klass.send(:define_method, signature.name) do |*args|
        method = Pyrex::Method.new(signature, block)
        method.verify_inputs(args)
        method.call(args)
      end
    end

    def initialize signature, code_to_execute 
      @signature       = signature
      @code_to_execute = code_to_execute 
    end

    def verify_inputs(args)
      Pyrex::ParamValidator.validate_params(@signature, @code_to_execute, args)
    end

    def call(args) 
      return_value = @code_to_execute.call(*args)
      validate_return_value(return_value)
    end

    private

    # TODO: This is not working :/
    def validate_return_value(return_value)
      raise "Type mismatch" unless @signature.valid_return?(return_value)

      return return_value
    end
  end
end
