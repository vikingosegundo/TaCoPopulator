#
# Be sure to run `pod lib lint TaCoPopulator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TaCoPopulator'
  s.version          = '0.1.2'
  s.summary          = 'A datasource framework for Table and Collection Views.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TaCoPopulator allows to cretate datasources that will work with UITableViews and UICollectionViews. It is designed to not interfere with the way you use those view. 
DESC

  s.homepage         = 'https://gitlab.com/vikingosegundo/TaCoPopulator'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Manuel Meyer' => 'vikingosegundo@gmailcom' }
  s.source           = { :git => 'https://gitlab.com/vikingosegundo/TaCoPopulator.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/vikingosegundo'

  s.ios.deployment_target = '8.0'

  s.source_files = 'TaCoPopulator/Classes/**/*'
end
