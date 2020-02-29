# frozen_string_literal: true

require File.expand_path('lib/active_record/pg_deferrable/version', __dir__)

Gem::Specification.new do |spec|
  spec.name          = 'activerecord-pg_deferrable'
  spec.version       = ActiveRecord::PgDeferrable::VERSION
  spec.authors       = ['Michael Herold']
  spec.email         = ['opensource@michaeljherold.com']

  spec.summary       = 'Add deferrable constraints to ActiveRecord'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/michaelherold/activerecord-pg_deferrable'
  spec.license       = 'MIT'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', '>= 4.1.0'
  spec.add_dependency 'pg'

  spec.add_development_dependency 'activesupport'
  spec.add_development_dependency 'appraisal'
  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'minitest-reporters'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'simplecov'
end
