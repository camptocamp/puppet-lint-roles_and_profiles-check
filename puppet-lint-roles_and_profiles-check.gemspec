Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-roles_and_profiles-check'
  spec.version     = '0.1.0'
  spec.homepage    = 'https://github.com/mcanevet/puppet-lint-roles_and_profiles-check'
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
  spec.summary     = 'A puppet-lint plugin to check some Roles&Profiles bests practices.'
  spec.description = <<-EOF
    A puppet-lint plugin to check that:
    - a node definition declares only a role,
    - a role class does not have any param and only declares profiles,
    - a profiles class can declare anything but a role.
  EOF

  spec.add_dependency             'puppet-lint', '>= 1.0', '< 3.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 1.0'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1.0'
  spec.add_development_dependency 'rake'
end
