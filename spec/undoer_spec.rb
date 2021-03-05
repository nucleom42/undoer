require 'spec_helper'

describe Undoer do
  let(:klass) { Class.new { include Undoer } }
  let(:object) { klass.new }

  describe 'instance methods' do
    describe '#restore' do

      it 'responds to the method' do
        expect(object).to respond_to(:restore)
      end

      context 'when target is hash' do
        let(:hash) { { "one" => 1, "two" => { "tree" => 3 }, "four" => 4 } }
        let(:eleven) { 11 }
        let(:twelve) { 12 }

        context 'when yielded logic raise ArgumentError error' do
          it 'restores initial hash' do
            object.restore target: hash, if_errors: [ArgumentError] do |h|
              h["one"] = eleven
              h["two"]["tree"] = twelve
              raise ArgumentError, 'Oioioi'
            end
            expect(hash["one"]).to eq 1
            expect(hash["two"]["tree"]).to eq 3
          rescue ArgumentError
            nil
          end
        end

        context 'when yielded logic not raises errors' do
          it 'changes an object' do
            object.restore target: hash, if_errors: [ArgumentError] do |h|
              h["one"] = eleven
              h["two"]["tree"] = twelve
            end
            expect(hash["one"]).to eq eleven
            expect(hash["two"]["tree"]).to eq twelve
          end
        end
      end
    end
  end

  describe 'class methods' do
    describe '#restore' do

      it 'responds to the method' do
        expect(klass).to respond_to(:restore)
      end

      context 'when target is hash' do
        let(:hash) { { "one" => 1, "two" => { "tree" => 3 }, "four" => 4 } }
        let(:eleven) { 11 }
        let(:twelve) { 12 }

        context 'when yielded logic raise ArgumentError error' do
          it 'restores initial hash' do
            klass.restore target: hash, if_errors: [ArgumentError] do |h|
              h["one"] = eleven
              h["two"]["tree"] = twelve
              raise ArgumentError, 'Oioioi'
            end
            expect(hash["one"]).to eq 1
            expect(hash["two"]["tree"]).to eq 3
          rescue ArgumentError
            nil
          end
        end

        context 'when yielded logic not raises errors' do
          it 'changes an object' do
            klass.restore target: hash, if_errors: [ArgumentError] do |h|
              h["one"] = eleven
              h["two"]["tree"] = twelve
            end
            expect(hash["one"]).to eq eleven
            expect(hash["two"]["tree"]).to eq twelve
          end
        end
      end

      context 'when target is array' do
        let(:array) { [1, 2, [3, 4]] }
        let(:eleven) { 11 }
        let(:twelve) { 12 }

        context 'when yielded logic raise ArgumentError error' do
          it 'restores initial array' do
            klass.restore target: array, if_errors: [ArgumentError] do |h|
              h[0] = eleven
              h[2][0] = twelve
              raise ArgumentError, 'Oioioi'
            end
            expect(array[0]).to eq 1
            expect(array[2][0]).to eq 3
          rescue ArgumentError
            nil
          end
        end

        context 'when yielded logic not raises errors' do
          it 'changes an array' do
            klass.restore target: array, if_errors: [ArgumentError] do |h|
              h[0] = eleven
              h[2][0] = twelve
            end
            expect(array[0]).to eq eleven
            expect(array[2][0]).to eq twelve
          end
        end
      end
    end

    context 'when target is instance' do
      let(:new_value) { 11 }
      let(:test_klas) { TestClass = (Class.new) }
      let(:test_instance) { test_klas.new }

      before do
        test_instance.instance_variable_set("@one", 1)
        test_instance.instance_variable_set("@two", 2)
      end

      it 'restores initial instance' do
        klass.restore target: test_instance, if_errors: [ArgumentError] do |i|
          i.instance_variable_set('@one', new_value)
          raise ArgumentError, 'Oioioi'
        end
        expect(test_instance.instance_variable_get('@one')).to eq 1
      rescue ArgumentError
        nil
      end
    end

    context 'when target is class' do
      let(:new_value) { 11 }
      let(:test_klas) { TestClass = (Class.new) }

      before do
        test_klas.class_variable_set("@@one", 1)
        test_klas.class_variable_set("@@two", 2)
      end

      it 'restores initial instance' do
        klass.restore target: test_klas, if_errors: [ArgumentError] do |i|
          i.class_variable_set('@@one', new_value)
          raise ArgumentError, 'Oioioi'
        end
        expect(test_klas.class_variable_get('@@one')).to eq 1
      rescue ArgumentError
        nil
      end
    end

    context 'when target is string' do
      let(:test_string) { "initial state" }

      context 'when yielded logic raise ArgumentError error' do
        it 'restores initial string' do
          klass.restore target: test_string, if_errors: [ArgumentError] do |s|
            s.gsub!('initial', 'modified')
            raise ArgumentError, 'Oioioi'
          end
          expect(test_string).to eq "initial state"
        rescue ArgumentError
          nil
        end
      end
    end

    context 'when target is numeric' do
      let(:test_numeric) { 1 }

      context 'when yielded logic raise ArgumentError error' do
        it 're raise ArgumentError' do
          expect { klass.restore target: test_numeric, if_errors: [ArgumentError] do |n|
            n = 2
            raise ArgumentError, 'Oioioi'
          end
          }.to raise_error(ArgumentError).with_message("not restoreable!")
        rescue ArgumentError
          nil
        end
      end
    end
  end
end
