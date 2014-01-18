Pod::Spec.new do |s|

  s.name         = "ReactiveCoreData"
  s.version      = "0.0.4"
  s.summary      = "Reactive extensions for Apple Core Data classes."

  s.description  = <<-DESC
                   ReactiveCocoa extensions for Apple Core Data classes.
                   Provides a consistent interface for methods that return errors
                   and utility methods to add observers for Core Data notifications.
                   DESC

  s.homepage     = "https://github.com/autodesk-acg/ReactiveCoreData"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Kent Wong" => "kent.wong@autodesk.com" }
  s.ios.deployment_target = '6.0'
  s.osx.deployment_target = '10.7'
  s.source       = { :git => "https://github.com/autodesk-acg/ReactiveCoreData.git", :tag => "0.0.4" }
  s.source_files = 'Classes/**/*.{h,m}'
  s.frameworks   = 'CoreData', 'Foundation'
  s.requires_arc = true
  
  s.dependency 'ReactiveCocoa', '~> 2.1.8'

  s.subspec 'OSX' do |sp|
    sp.osx.exclude_files = 'Classes/ios/**/*.{h,m}'
  end

  s.subspec 'iOS' do |sp|
    sp.ios.exclude_files = 'Classes/osx/**/*.{h,m}'
  end

end
