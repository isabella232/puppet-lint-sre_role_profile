Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-sre_role_profile'
  spec.version     = '0.0.1'
  spec.homepage    = 'https://github.com/puppetlabs/puppet-lint-sre_role_profile'
  spec.license     = 'MIT'
  spec.author      = ['Gene Liverman']
  spec.email       = ['gene.liverman@puppet.com']
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    'lib/**/*',
    'spec/**/*',
  ]
  spec.test_files  = Dir['spec/**/*']
  spec.summary     = "puppet-lint check to validate that SRE's control repo adheres to our style guide for role and profile usage"
  spec.description = <<-EOF
    This puppet-lint extension validates that:
    - roles only `include` profiles
    - roles are not included in other classes
  EOF

  spec.add_dependency             'puppet-lint', '>= 1.1', '< 3.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 1.0'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1.0'
  spec.add_development_dependency 'simplecov', '~> 0.16'
  spec.add_development_dependency 'rake'
end
