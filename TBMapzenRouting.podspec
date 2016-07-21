Pod::Spec.new do |s|

  s.name         = "TBMapzenRouting"
  s.version      = "0.1"
  s.summary      = "Request routes from Mapzen Turn-by-Turn routing service"

  s.description  = <<-DESC
                  Request routes from Mapzen Turn-by-Turn routing service
                   DESC

  s.homepage     = "https://github.com/trailbehind/TBMapzenRouting"
  s.license      = "MIT"

  s.author             = { "TrailBehind, Inc." => "Jesse@Gaiagps.com" }
  s.social_media_url   = "http://twitter.com/gaiagps"

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/trailbehind/TBMapzenRouting.git", :tag => "0.1" }

  s.source_files  = "TBMapzenRouting/*.{h,m,c}"
  s.framework = "CoreLocation"

end
