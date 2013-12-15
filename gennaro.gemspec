Kernel.load 'lib/gennaro/version.rb'

Gem::Specification.new { |s|
  s.name          = 'gennaro'
  s.version       = Gennaro.version
  s.author        = 'Giovanni Capuano'
  s.email         = 'webmaster@giovannicapuano.net'
  s.homepage      = 'http://www.giovannicapuano.net'
  s.platform      = Gem::Platform::RUBY
  s.summary       = 'Sinatra template generator.'
  s.description   = 'Generate templates for Sinatra. The built-in template provide a user authentication model, but you can add as many templates as you want.'
  s.licenses      = 'WTFPL'

  s.require_paths = ['lib']
  s.executables   = 'gennaro'
  s.files         = Dir.glob('lib/**/*.rb') + Dir.glob('templates/**/*')
  s.test_files    = Dir.glob('spec/**/*_spec.rb')

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'
}