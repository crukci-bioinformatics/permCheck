# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = PermCheck::PACKAGE
  spec.version       = PermCheck::VERSION
  spec.authors       = ["Gord Brown"]
  spec.email         = ["gordon.brown@cruk.cam.ac.uk"]

  spec.summary       = %q{Report permissions problems on shared code paths.}
  spec.description   = %q{Group policy is to have shared code paths read-only
                          to owner and others, read-write to group
                          sec-bioinf-softwareadmins, and group-owned by
                          sec-bioinf-softwareadmins, so that we won't clobber
                          anything accidentally.}
  spec.homepage      = "https://github.com/gdbzork"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = ["permCheck"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
