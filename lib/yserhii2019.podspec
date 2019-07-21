#
# Be sure to run `pod lib lint yserhii2019.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'yserhii2019'
  s.version          = '0.1.0'
  s.summary          = 'My CoreData'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: In this description will be many funny func.
                       DESC

  s.homepage         = 'https://github.com/Yserhii'
  s.swift_version    = '5.0'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Yserhii' => 'semik93@bk.ru' }
  s.source           = { :git => 'https://github.com/Yserhii/yserhii2019.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.2'

  s.source_files = 'yserhii2019/Classes/**/*'
  
  # s.resource_bundles = {
  #   'yserhii2019' => ['yserhii2019/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'CoreData'
  # s.dependency 'AFNetworking', '~> 2.3'
end
