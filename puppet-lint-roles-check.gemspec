Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-roles-check'
  spec.version     = '0.0.1'
  spec.homepage    = 'https://github.com/mcanevet/puppet-lint-roles-check'
  spec.license     = 'MIT'
  spec.author      = 'Mickaël Canévet'
  spec.email       = 'mickael.canevet@gmail.com'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    'lib/**/*',
    'spec/**/*',
  ]
  spec.test_files  = Dir['spec/**/*']
  spec.summary     = 'A puppet-lint plugin to check if role is valid.'
  spec.description = <<-EOF
    A puppet-lint plugin to check that a role manifest does not have any param and only includes profiles.
  EOF

  spec.add_dependency             'puppet-lint', '~> 1.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 1.0'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1.0'
  spec.add_development_dependency 'rake'
end
