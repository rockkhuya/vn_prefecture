# -*- encoding: utf-8 -*-
require File.expand_path('../lib/vn_prefecture/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Luu Tuan Anh"]
  gem.email         = ["rock.khuya@gmail.com"]
  gem.summary       = %q{Convert Vietnam prefecture code into prefecture name}
  gem.description   = %q{Convert Vietnam prefecture code(unicode) into prefecture name. Fork form VnPrefecture}
  gem.homepage      = "https://github.com/rockkhuya/vn_prefecture"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "vn_prefecture"
  gem.require_paths = ["lib"]
  gem.version       = VnPrefecture::VERSION

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", "~> 2.14.1"
  gem.add_development_dependency "activerecord", ">= 3.2.0"
  gem.add_development_dependency "sqlite3"
end
