Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_gift_packaging'
  s.version     = '0.3.1'
  s.summary     = 'Spree Commerce Extensions for Gift Packaging'

  s.author        = 'Thomas Boltze'
  s.email         = 'thomas.boltze@gmail.com'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.has_rdoc = false
end
