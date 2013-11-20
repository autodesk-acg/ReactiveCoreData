#
#  Be sure to run `pod spec lint ReactiveCoreData.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "ReactiveCoreData"
  s.version      = "0.0.1"
  s.summary      = "Reactive extensions for Apple Core Data classes."

  s.description  = <<-DESC
                   ReactiveCocoa extensions for Core Data.
                   DESC

  s.homepage     = "https://github.com/autodesk-acg/ReactiveCoreData"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Kent Wong" => "kent.wong@autodesk.com" }
  s.platform     = :ios, '6.0'
  s.source       = { :git => "https://github.com/autodesk-acg/ReactiveCoreData.git", :tag => "0.0.1" }
  s.source_files = 'Source/ReactiveCoreData/*RCDExtensions.{h,m}'
  s.frameworks   = 'CoreData', 'Foundation'
  s.requires_arc = true
  s.dependency 'ReactiveCocoa', '~> 2.1.7'

end
