# frozen_string_literal: true

require_relative 'lib/http_service/version'

Gem::Specification.new do |spec|
  spec.name = 'http_service'
  spec.version = HTTPService::VERSION

  spec.summary = 'Service-object-oriented HTTP client wrapper build on Faraday.'
  spec.description = 'Gem designed for cleaner and more intuitive way of handling HTTP requests
                     adhering to the Service-Object pattern.'

  spec.authors = ['@aevula']
  spec.homepage = 'https://github.com/aevula/http_service'
  spec.license = 'MIT'

  spec.required_ruby_version = '>= 3.4'

  spec.metadata = {
    'homepage_uri'          => 'https://github.com/aevula/http_service',
    'source_code_uri'       => 'https://github.com/aevula/http_service/tree/master',
    'changelog_uri'         => 'https://github.com/aevula/http_service/tree/master/CHANGELOG.md',
    'rubygems_mfa_required' => 'true'
  }

  spec.files = ['README.md', 'LICENSE.txt']

  spec.require_paths = ['lib']

  spec.add_dependency('activesupport')
  spec.add_dependency('faraday', '~> 2.0')
  spec.add_dependency('faraday-multipart', '~> 1.0')
  spec.add_dependency('faraday-net_http_persistent', '~> 2.0')
end
