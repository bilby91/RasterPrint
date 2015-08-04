Pod::Spec.new do |s|
  s.name             = "RasterPrint"
  s.version          = "0.1.0"
  s.summary          = "RasterPrint, print raster graphics."
  s.homepage         = "https://github.com/bilby91/RasterPrint"
  s.license          = 'MIT'
  s.author           = { "Martin Fernandez" => "me@bilby91.com" }
  s.source           = { :git => "https://github.com/bilby91/RasterPrint.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/bilby91'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.default_subspec = 'Core'

  s.subspec 'Core' do |cs|
    cs.source_files        = 'Pod/Classes/Core'
    cs.public_header_files = 'Pod/Classes/Core/**/*.h'

    cs.frameworks = 'ExternalAccessory', 'CoreGraphics'

    cs.vendored_frameworks = 'Vendor/StarIO.framework'
  end

  s.subspec 'Reactive' do |rs|
    rs.source_files   = 'Pod/Classes/Reactive'

    rs.dependency       'ReactiveCocoa', '~> 2.4'
    rs.dependency       'RasterPrint/Core'
  end

end
