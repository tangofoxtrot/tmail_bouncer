# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tmail_bouncer}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["tangofoxtrot"]
  s.date = %q{2009-05-29}
  s.email = %q{richard.luther@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "lib/bouncers/base.rb",
    "lib/bouncers/no_bouncer.rb",
    "lib/bouncers/standard_bouncer.rb",
    "lib/tmail_bouncer.rb",
    "test/fixtures/yahoo.eml",
    "test/fixtures/yahoo_legit.eml",
    "test/test_helper.rb",
    "test/unit/tmail_bouncer_test.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/tangofoxtrot/tmail_bouncer}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TODO}
  s.test_files = [
    "test/test_helper.rb",
    "test/unit/tmail_bouncer_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
