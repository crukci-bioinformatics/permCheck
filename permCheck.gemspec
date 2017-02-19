# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'permCheck/version'

Gem::Specification.new do |spec|
  spec.name          = PermCheck::PACKAGE
  spec.version       = PermCheck::VERSION
  spec.authors       = ["Gord Brown"]
  spec.email         = ["gordon.brown@cruk.cam.ac.uk"]

  spec.summary       = %q{Check permissions on a filesystem hierarchy,
                          reporting sub-hierarchies that do not match
                          permissions and/or group ownership.}
  spec.description   = %q{Given a umask and group, traverse a filesystem
                          hierarchy rooted at some path, reporting files
                          and directories that do not match.  The intent
                          is to enforce standards for locking down
                          shared directories so that they are not changed
                          accidentally by users.  In our case, the group
                          policy is to have shared code paths read-only
                          to owner and others, read-write to group
                          sec-bioinf-softwareadmins, and group-owned by
                          sec-bioinf-softwareadmins, so that we won't clobber
                          anything accidentally, but instead have to change
                          groups to sec-bioinf-softwareadmins to change
                          anything.}

  spec.homepage      = "https://github.com/crukci-bioinformatics/permCheck"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = ["permCheck"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_runtime_dependency "mail", "~> 2.6"
end
