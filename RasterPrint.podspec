Pod::Spec.new do |s|
  s.name             = "RasterPrint"
  s.version          = "0.1.0"
  s.summary          = "RasterPrint, print raster graphics."
  s.homepage         = "https://github.com/bilby91/RasterPrint"
  s.license          = 'MIT'
  s.author           = { "Martin Fernandez" => "me@bilby91.com" }
  s.source           = { :git => "https://github.com/bilby91/RasterPrint.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/bilby91'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.prefix_header_contents = #define symbolToDefine
  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'ExternalAccessory', 'CoreGraphics'
  s.vendored_frameworks = 'Vendor/StarIO.framework'
#s.dependency 'StarIO'
end
