# frozen_string_literal: true

require 'hash'
require 'array'
require 'string'
require 'object'
require 'class'

module Undoer
  NOT_SUPPORTED  = [Numeric, TrueClass, FalseClass, Symbol, Numeric].freeze
  
  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
  end

  module InstanceMethods
    def restore(options = {}, &block)
      self.class.restore(options, &block)
    end
  end

  module ClassMethods
    def restore(options = {}, &block)
      target = options[:target]
      errors = options[:if_errors] || [StandardError].freeze
      cloned_target = target.respond_to?('new') ? target.clone : Marshal.load( Marshal.dump(target) )
      yield(target)
    rescue *errors => e
      raise ArgumentError, "not restoreable!" if target.is_any?(NOT_SUPPORTED)
      target.deep_copy!(cloned_target)
    end
  end
end
