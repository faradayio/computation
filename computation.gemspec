Gem::Specification.new do |s|
  s.name = %q{computation}
  s.version = "0.0.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andy Rossmeissl", "Seamus Abshere", "Ian Hough", "Matt Kling", "Derek Kastner"]
  s.date = %q{2010-12-22}
  s.description = %q{A software model in Ruby for the greenhouse gas emissions of a computer's computations}
  s.email = %q{andy@rossmeissl.net}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc",
    "TODO"
  ]
  s.files = Dir.glob('lib/**/*') + [
    "LICENSE",
    "README.rdoc"
  ]
  s.homepage = %q{http://github.com/brighterplanet/computation}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{A carbon model}
  s.test_files = Dir.glob('features/**/*') + [
    "lib/test_support/computation_record.rb"
  ]

  s.specification_version = 3

  s.add_development_dependency 'bueller'
  s.add_development_dependency 'sniff', '~> 0.4.9'
  s.add_runtime_dependency 'emitter', '~> 0.3'
end

