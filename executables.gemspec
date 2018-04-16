
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "executables/version"

Gem::Specification.new do |spec|
  spec.name          = "executables"
  spec.version       = Executables::VERSION
  spec.authors       = ["Rohit Patel"]
  spec.email         = ["rohit.patel061@gmail.com"]

  spec.summary       = %q{Executables gives you an ability to run your rails app's executables via a web interface.

With the help of simple configuration options you can tell executables to expose your executables. Executables will fetch all the executables as per the configuration options, along with their respective executable methods and arguments they accept thus giving you an ability to execute them.

Read more here to know more about the intentions behind building executables
}
  spec.description   = %q{Run your rails app's executables via a web interface
}
  spec.homepage      = "https://github.com/rohitcy/executables"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "byebug"
end
