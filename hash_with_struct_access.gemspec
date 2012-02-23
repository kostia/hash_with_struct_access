# -*- encoding: utf-8 -*-

require File.expand_path("../lib/hash_with_struct_access", __FILE__)

Gem::Specification.new do |gem|
  gem.name = "hash_with_struct_access"
  gem.version = HashWithStructAccess::VERSION
  gem.description = %q{Hash object with struct access}
  gem.summary = %q{Hash object with struct access. Main purpose is to be a configuration object.}
  gem.homepage = "https://github.com/kostia/hash_with_struct_access"
  gem.authors = ["Kostiantyn Kahanskyi"]
  gem.email = %w(kostiantyn.kahanskyi@googlemail.com)
  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- test/*`.split("\n")
  gem.require_paths = %w(lib)
  gem.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  gem.required_ruby_version = ">= 1.9.3"
  gem.add_development_dependency("minitest")
  gem.add_development_dependency("rake")
  gem.add_development_dependency("turn")
end
