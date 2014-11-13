# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'capture_output_streams/version'

Gem::Specification.new do |spec|
  spec.name          = "capture_output_streams"
  spec.version       = CaptureOutputStream::VERSION
  spec.authors       = ["Marc Sutter"]
  spec.email         = ["marc.sutter@swisscom.com"]
  spec.summary       = %q{control output streams of third party gems or libraries}
  spec.description   = %q{hide or reformat output streams of required third party code}
  spec.homepage      = "https://github.com/msutter/capture_output_streams"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "open4"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
end
