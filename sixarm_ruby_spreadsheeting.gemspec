Gem::Specification.new do |s|

  s.name              = "sixarm_ruby_spreadsheeting"
  s.summary           = "SixArm Ruby Gem: Spreadsheeting import export helpers, to parse and prettify"
  s.version           = "1.0.6"
  s.author            = "SixArm"
  s.email             = "sixarm@sixarm.com"
  s.homepage          = "http://sixarm.com/"
  s.signing_key       = '/home/sixarm/keys/certs/sixarm.com.rsa.private.key.and.certificate.pem'
  s.cert_chain        = ['/home/sixarm/keys/certs/sixarm.pem']

  s.platform          = Gem::Platform::RUBY
  s.require_path      = 'lib'
  s.has_rdoc          = true
  s.files             = ['README.rdoc','LICENSE.txt','lib/sixarm_ruby_spreadsheeting.rb']
  s.test_files        = ['test/sixarm_ruby_spreadsheeting_test.rb']

end
