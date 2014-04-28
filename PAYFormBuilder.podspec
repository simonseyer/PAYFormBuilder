Pod::Spec.new do |s|
  s.name         = "PAYFormBuilder"
  s.version      = "1.0.0"
  s.summary      = "Library to create iOS 7 forms with block based syntax"
  s.description  = <<-DESC
                   With the PAYFormBuilder you could easily create forms with iOS 7 style. Some of the features are:

                   * **Easy syntax** - with the block syntax your code is well structured and easy to understand
				   * **Predefined Styles** - get a seamless iOS 7 feeling without writing one line of styling code
				   * **Validation** - use validation handling and error message management out of the box
				   * **Customizable** - change many defaults with UIAppearence or configure each element individually 
				   * **Example app** - get an overview over all posibilities of the lib and see how to get the best out of it
                   DESC
  s.homepage     = "https://github.com/redpeppix-gmbh-co-kg/PAYFormBuilder"
  s.screenshots  = ["https://github.com/redpeppix-gmbh-co-kg/PAYFormBuilder/blob/master/Images/registrationForm3.png", 
  					"https://github.com/redpeppix-gmbh-co-kg/PAYFormBuilder/blob/master/Images/controls.png", 
  					"https://github.com/redpeppix-gmbh-co-kg/PAYFormBuilder/blob/master/Images/controls2.png"]
  s.license        = 'MIT'
  s.author         = { "Simon Seyer" => "seyer@redpeppix.de" }
  s.platform       = :ios, '7.0'
  s.source         = { :git => "https://github.com/redpeppix-gmbh-co-kg/PAYFormBuilder.git", :tag => s.version.to_s }
  s.source_files   = 'PAYFormBuilder/**/*.{h,m}'
  s.ios.frameworks = "UIKit"
  s.requires_arc   = true
  s.dependency 'BlocksKit', '~> 2'
  s.dependency 'libextobjc',   '~> 0.4'
  s.dependency 'SZTextView',   '~> 1.1'
end