#
# Be sure to run `pod lib lint GLCodeReview.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GLCodeReview'
  s.version          = '0.1.0'
  s.summary          = 'Swift wrapper for GitLab API code review endpoints.'
  s.homepage         = 'https://github.com/guillermomuntaner/GLCodeReview'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Guillermo Muntaner' => 'guillermomp87@gmail.com' }
  s.source           = { :git => 'https://github.com/guillermomuntaner/GLCodeReview.git', :tag =>  s.version.to_s }
  s.social_media_url = 'https://twitter.com/guillermomp87'
  
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  
  s.source_files = 'GLCodeReview/Classes/**/*'
  
  s.frameworks = 'Foundation'
end
