require_relative 'method'
require_relative 'signature'
require_relative 'errors'

module Pyrex
  class Glass
    SAFE_METHODS = %w(pdef).freeze

    def self.pdef method_signature, &block
      signature = Pyrex::Signature.build(method_signature)

      Pyrex::Method.define_method_for_class(self.class, signature, block)
    end

    def self.method_added(method_name)
      super if SAFE_METHODS.include?(method_name) 
      super if method_name.to_s.start_with?('__')

      raise Pyrex::Errors::PreventDefUsage.new(method_name: method_name)
    end
  end
end
