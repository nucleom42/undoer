# frozen_string_literal: true

require 'spec_helper'
require 'net/http'

describe Undoer do
  let(:klass) { Class.new { include Undoer } }
  let(:object) { klass.new }

  describe 'instance methods' do
    describe '#restore' do

      it 'responds to the method' do
        expect(object).to respond_to(:restore)
      end
    end
  end

  describe 'class methods' do
    describe '#restore' do

      it 'responds to the method' do
        expect(klass).to respond_to(:restore)
      end
    end
  end
end
