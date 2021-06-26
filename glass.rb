require_relative 'method'
require_relative 'signature'
require_relative 'errors'

module Pyrex
  class Glass
    SAFE_METHODS = %i(initialize method_missing).freeze

    class << self
      def [](superclass)
        # 🤷
        return self
      end

      def pdef method_signature, &block
        signature = Pyrex::Signature.build(method_signature)

        Pyrex::Method.define_instance_method(self, signature, block)
      end

      def self_pdef method_signature, &block
        signature = Pyrex::Signature.build(method_signature)

        Pyrex::Method.define_class_method(self, signature, block)
      end

      def method_added(method_name)
        return super if SAFE_METHODS.include?(method_name)
        return super if method_name.to_s.start_with?('__')

        raise Pyrex::Errors::PreventDefUsage.new(method_name: method_name)
      end
    end

    def initialize(*args)
      if self.class.instance_methods(false).include?(:__init)
        __init(*args)        
      else
        super
      end
    end

    def method_missing(method_name, *args, &block)
      if self.class.instance_methods(false).include?(:"__#{method_name}")
        send("__#{method_name}", *args)
      else
        super
      end
    end
  end
end
