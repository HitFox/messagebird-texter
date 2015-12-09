# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'messagebird_texter/version'

Gem::Specification.new do |spec|
  spec.name          = 'messagebird-texter'
  spec.version       = MessagebirdTexter.version
  spec.authors       = ['oliverzeyen']
  spec.email         = ['oliver.zeyen@hitfoxgroup.com']

  spec.summary       = 'Wrapper for the Messagebird SMS Gateway API.'
  spec.description   = 'Send text messages/sms by means of the HTTP protocol with the service of https://www.messagebird.com.'
  spec.homepage      = 'https://github.com/HitFox/messagebird-sms'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 1.0'

  if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0')
    spec.add_runtime_dependency 'phony', '~> 2.12'
    spec.add_runtime_dependency 'action-texter'
  else
    spec.add_dependency 'phony', '~> 2.15'
    spec.add_dependency 'action-texter'
  end
end
