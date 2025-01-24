# frozen_string_literal: true

require 'simplecov-cobertura'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [SimpleCov::Formatter::HTMLFormatter, SimpleCov::Formatter::CoberturaFormatter])

SimpleCov.coverage_dir(ENV.fetch('COVERAGE_DIR', 'coverage'))

SimpleCov.start do
  minimum_coverage(80)
  enable_coverage(:branch)
end
