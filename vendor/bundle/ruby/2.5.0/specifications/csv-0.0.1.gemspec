# -*- encoding: utf-8 -*-
# stub: csv 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "csv".freeze
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["James Edward Gray II".freeze]
  s.bindir = "exe".freeze
  s.date = "2017-05-11"
  s.description = "the CSV library began its life as FasterCSV.".freeze
  s.email = [nil]
  s.homepage = "https://github.com/ruby/csv".freeze
  s.licenses = ["BSD-2-Clause".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.5.0dev".freeze)
  s.rubygems_version = "2.7.6".freeze
  s.summary = "CSV Reading and Writing".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.14"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.14"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.14"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
  end
end
