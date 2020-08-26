#
# Be sure to run `pod lib lint CPush.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CPush'
  s.version          = '0.1.0'
  s.summary          = 'A short description of CPush.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/BShark-YB/CPush'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'BShark-YB' => 'andy_ybcao@tutorabc.com.cn' }
  s.source           = { :git => 'https://github.com/BShark-YB/CPush.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.static_framework = true
  s.default_subspec = 'Core'
  s.swift_version = '5.1'
  
  s.subspec 'Plan' do |plan|
      plan.source_files = 'CPush/Classes/Plan/**/*.swift'
  end
  
  s.subspec 'Core' do |core|
      core.source_files = 'CPush/Classes/Core/**/*.swift'
    core.resource_bundles = {
        'CPush' => ['CPush/Assets/Core/*.{xib,json,png,plist,xcassets}']
    }
    core.dependency 'SnapKit'
    core.dependency 'mob_pushsdk'

  end

end
