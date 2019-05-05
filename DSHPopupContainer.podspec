#
#  Be sure to run `pod spec lint DSHPopupContainer.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "DSHPopupContainer"
  s.version      = "1.0.3"
  s.summary      = "iOS弹层容器"
  s.description  = <<-DESC
                    用来自定义弹层动画，管理弹层的小工具。
                    DESC
  s.homepage     = "https://github.com/568071718/DSHPopupContainer"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "lu" => "568071718@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/568071718/DSHPopupContainer.git", :tag => s.version }
  s.requires_arc = true
  
  s.subspec 'Base' do |ss|
      ss.source_files = 'Classes'
  end
  
  s.subspec 'AlertView' do |ss|
      ss.dependency 'DSHPopupContainer/Base'
      ss.source_files = 'AlertView'
  end
  
end
