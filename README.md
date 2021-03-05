## Shotgunner

![Gem](https://img.shields.io/gem/dt/undoer.svg)
![GitHub last commit](https://img.shields.io/github/last-commit/nucleom42/undoer.svg)
![Gem](https://img.shields.io/gem/v/undoer.svg)

1. Define errors array for restoring original object
2. Yield logic which changes object.
3. Get restored object if mentioned errors occurred

## Install

```ruby

gem install undoer

```

## Examples

```ruby

class Service
  include Undoer

  class << self
    def execute
      obj = { "one" => 1, "two" => { "tree" => 3 }, "four" => 4 }

      restore target: obj, if_errors: [NoMethodError] do |obj|
        # logic which modifies object
        obj["one"] = 11
        
        # call method which raises NoMethodError
        obj.call_some_not_existing_method
      end

      ## get initial object without any additional manipulation
      pp 'Hurray, I have initial object!' if obj["one"] == 1
    end
  end
end

```