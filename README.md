## Undoer

![Gem](https://img.shields.io/gem/dt/undoer.svg)
![GitHub last commit](https://img.shields.io/github/last-commit/nucleom42/undoer.svg)
![Gem](https://img.shields.io/gem/v/undoer.svg)

Problem:

* Need to restore initial object if specific errors occurred in the similar way of transaction block works in Active Records

Solution:
1. Define errors array for restoring original mutable object
2. Yield logic which changes object
3. Get restored object if mentioned errors occurred

Notes:

Works based on deep copying approach injected in Ruby classes. Won't work with immutable objects like Numeric, Boolean ..

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
      john = Student.new('John', 32)

      restore target: john, if_errors: [NoMethodError] do |obj|
        # logic which modifies object
        obj.age = 40
        
        # call method which raises NoMethodError (as an example)
        obj.call_some_not_existing_method
      end

      ## get initial object without any additional manipulation
      pp 'Hurray, John is still 32!' if john.age == 32
    end
  end
end

```