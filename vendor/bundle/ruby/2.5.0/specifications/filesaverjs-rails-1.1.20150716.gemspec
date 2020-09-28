# -*- encoding: utf-8 -*-
# stub: filesaverjs-rails 1.1.20150716 ruby lib

Gem::Specification.new do |s|
  s.name = "filesaverjs-rails".freeze
  s.version = "1.1.20150716"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Dinesh Sawant".freeze]
  s.bindir = "exe".freeze
  s.date = "2015-07-27"
  s.email = ["dineshs@idfy.com".freeze]
  s.homepage = "https://github.com/dinsaw/filesaverjs-rails".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.6".freeze
  s.summary = "filesaverjs-rails is a simple gem to add FileSaver.js vendor file to Rails asset pipeline.".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.10"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<minitest>.freeze, [">= 0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.10"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<minitest>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.10"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<minitest>.freeze, [">= 0"])
  end
end
