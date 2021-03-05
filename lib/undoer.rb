# frozen_string_literal: true

module Undoer

  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
  end

  module InstanceMethods
    def restore(options = {}, &block)
      self.class.undo(options, &block)
    end
  end

  module ClassMethods
    def restore(options = {}, &block) end
  end
end
