$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "trough/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "trough"
  s.version     = Trough::VERSION
  s.authors     = ["Greg Woodcock"]
  s.email       = ["greg@yoomee.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Trough."
  s.description = "TODO: Description of Trough."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0"
  s.add_dependency "cancancan"
  s.add_dependency "refile"
  s.add_dependency "refile-s3"
  s.add_dependency "aws-sdk"
  s.add_dependency 'formtastic-bootstrap', '~> 3.0'

  s.add_development_dependency "sqlite3"
end
