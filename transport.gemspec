# encoding: utf-8

Gem::Specification.new do |specification|
  specification.name                  = "transport"
  specification.version               = "1.0.1"
  specification.date                  = "2010-11-30"

  specification.authors               = [ "Philipp Brüll" ]
  specification.email                 = "b.phifty@gmail.com"
  specification.homepage              = "http://github.com/phifty/transport"
  specification.rubyforge_project     = "transport"

  specification.summary               = "A HTTP/JSON transport layer."
  specification.description           = "Provide a single command interface to perform http/json requests. A spec helper to perform request against a fake server is also included."

  specification.has_rdoc              = true
  specification.files                 = [ "README.rdoc", "LICENSE", "Rakefile" ] + Dir["lib/**/*"] + Dir["spec/**/*"]
  specification.extra_rdoc_files      = [ "README.rdoc" ]
  specification.require_path          = "lib"
  specification.required_ruby_version = ">= 1.8.7"

  specification.test_files            = Dir["spec/**/*_spec.rb"]

  specification.requirements << "The 'json' gem if ruby version 1.8.x is used."

  specification.add_development_dependency "rspec", ">= 2"
  specification.add_development_dependency "reek", ">= 1.2"
end
