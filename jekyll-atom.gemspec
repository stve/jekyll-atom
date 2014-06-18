Gem::Specification.new do |s|
  s.name        = "jekyll-atom"
  s.summary     = "Automatically generate an atom feed for your Jekyll site."
  s.version     = "0.1.0"
  s.authors     = ["GitHub, Inc."]
  s.email       = "support@github.com"
  s.homepage    = "https://github.com/github/jekyll-atom"
  s.licenses    = ["MIT"]

  s.files         = Dir["lib/*"]
  s.require_paths = ["lib"]

  s.add_dependency "jekyll", "~> 1.4"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"
end
