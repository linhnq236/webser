# -*- encoding: utf-8 -*-
# stub: reports_kit 0.7.1 ruby lib

Gem::Specification.new do |s|
  s.name = "reports_kit".freeze
  s.version = "0.7.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Tom Benner".freeze]
  s.date = "2018-07-01"
  s.description = "ReportsKit lets you easily create beautiful charts with customizable, interactive filters.".freeze
  s.email = ["tombenner@gmail.com".freeze]
  s.homepage = "https://github.com/tombenner/reports_kit".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Beautiful, interactive charts for Ruby on Rails".freeze

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>.freeze, [">= 3"])
      s.add_runtime_dependency(%q<spreadsheet>.freeze, [">= 1.1"])
      s.add_development_dependency(%q<appraisal>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec>.freeze, ["~> 3"])
      s.add_development_dependency(%q<database_cleaner>.freeze, ["~> 1"])
      s.add_development_dependency(%q<factory_girl>.freeze, ["~> 4"])
      s.add_development_dependency(%q<groupdate>.freeze, ["~> 3"])
      s.add_development_dependency(%q<pg>.freeze, [">= 0.15"])
      s.add_development_dependency(%q<pry>.freeze, ["~> 0"])
      s.add_development_dependency(%q<pry-byebug>.freeze, ["~> 1"])
      s.add_development_dependency(%q<timecop>.freeze, ["~> 0"])
    else
      s.add_dependency(%q<rails>.freeze, [">= 3"])
      s.add_dependency(%q<spreadsheet>.freeze, [">= 1.1"])
      s.add_dependency(%q<appraisal>.freeze, [">= 0"])
      s.add_dependency(%q<rspec>.freeze, ["~> 3"])
      s.add_dependency(%q<database_cleaner>.freeze, ["~> 1"])
      s.add_dependency(%q<factory_girl>.freeze, ["~> 4"])
      s.add_dependency(%q<groupdate>.freeze, ["~> 3"])
      s.add_dependency(%q<pg>.freeze, [">= 0.15"])
      s.add_dependency(%q<pry>.freeze, ["~> 0"])
      s.add_dependency(%q<pry-byebug>.freeze, ["~> 1"])
      s.add_dependency(%q<timecop>.freeze, ["~> 0"])
    end
  else
    s.add_dependency(%q<rails>.freeze, [">= 3"])
    s.add_dependency(%q<spreadsheet>.freeze, [">= 1.1"])
    s.add_dependency(%q<appraisal>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3"])
    s.add_dependency(%q<database_cleaner>.freeze, ["~> 1"])
    s.add_dependency(%q<factory_girl>.freeze, ["~> 4"])
    s.add_dependency(%q<groupdate>.freeze, ["~> 3"])
    s.add_dependency(%q<pg>.freeze, [">= 0.15"])
    s.add_dependency(%q<pry>.freeze, ["~> 0"])
    s.add_dependency(%q<pry-byebug>.freeze, ["~> 1"])
    s.add_dependency(%q<timecop>.freeze, ["~> 0"])
  end
end
