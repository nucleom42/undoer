Gem::Specification.new do |s|
  s.author = ["Oleg Saltykov"]
  s.homepage = "https://github.com/nucleom42/undoer"
  s.name = %q{undoer}
  s.version = "0.1.2"
  s.date = %q{2021-03-05}
  s.summary = %q{Undoer - simple way of restoring initial mutable object state if yielded logic raises specific errors}
  s.files = %w[lib/array.rb lib/class.rb lib/object.rb lib/hash.rb lib/string.rb lib/undoer.rb]
  s.require_paths = ["lib"]
end