#
#  Be sure to run `pod spec lint DSHPopupContainer.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "DSHPopupContainer"
  s.version      = "0.0.1"
  s.summary      = "A short description of DSHPopupContainer."
  s.description  = <<-DESC 弹层容器 DESC
  s.homepage     = "https://github.com/568071718/DSHPopupContainer"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/568071718/DSHPopupContainer.git", :tag => s.version }
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.requires_arc = true
end
