lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'spree_analytics_trackers/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_analytics_trackers'
  s.version     = SpreeAnalyticsTrackers.version
  s.summary     = 'Adds analytics trackers functionality to Spree'
  s.description = 'Supports Google Analytics '
  s.required_ruby_version = '>= 2.5.0'

  s.author    = 'Spark Solutions'
  s.email     = 'we@sparksolutions.co'
  s.homepage  = 'https://github.com/spree-contrib/spree_analytics_trackers'
  s.license = 'BSD-3-Clause'

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  spree_version = '>= 4.1.0', '< 5.0'
  s.add_dependency 'spree_core', spree_version
  s.add_dependency 'spree_backend', spree_version
  s.add_dependency 'spree_extension'
  s.add_dependency 'deface', '~> 1.0'

  s.add_development_dependency 'spree_dev_tools'
end
