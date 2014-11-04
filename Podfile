source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '7.0'
xcodeproj 'PAYFormBuilder.xcodeproj'
workspace 'PAYFormBuilder.xcworkspace'

pod 'BlocksKit',    '~> 2'
pod 'libextobjc',   '~> 0.4'
pod 'SZTextView',   '~> 1.1'

target :Example do
	pod 'PAYFormBuilder', :path => '.'
	xcodeproj 'Example.xcodeproj'
end

target :ExampleTests do
	pod 'PAYFormBuilder', :path => '.'
  	pod 'KIF/OCUnit', '~> 3.0'
	xcodeproj 'Example.xcodeproj'
end
