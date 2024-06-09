require_relative "lib/fatcow/version"

Gem::Specification.new do |spec|
  spec.name        = "fatcow"
  spec.version     = Fatcow::VERSION
  spec.authors     = ["Gray"]
  spec.email       = ["drones_depenses.0q@icloud.com"]
  spec.homepage    = "https://github.com/pupgray/fatcow"
  spec.summary     = "Fatcow raster icons for Rails."
  spec.description = "A gem to use the free Fatcow web icons in rails. All icons are provided under Creative Commons Attribution 3.0 as per the original license for the icons. Source is https://web.archive.org/web/20160323032439/http://www.fatcow.com/free-icons."
  spec.license     = "CC-BY-3.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", "~> 7"
  spec.add_dependency "nokogiri", "~> 1.8"
end
