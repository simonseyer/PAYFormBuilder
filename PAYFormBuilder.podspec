Pod::Spec.new do |s|
  s.name         = "PAYFormBuilder"
  s.version      = "3.1.2"

  s.summary      = "Library to create iOS 7/8 forms with a block based syntax"
  s.description  = <<-DESC
                   With the PAYFormBuilder you could easily create forms with iOS 7 style.

                   * **Easy syntax** - with the block syntax your code is well structured and easy to understand
                   * **Predefined Styles** - get a seamless iOS 7/8 feeling without writing one line of styling code
                   * **Validation** - use validation handling and error message management out of the box
                   * **Customizable** - change everything the `PAYFormBuilder` configured for you - just register some blocks and wait for a call 
                   * **Themable** - You decide, how your form should look like
                   * **Auto layout compatible** - For full flexibility all elements are positioned with auto layout
                   * **Example app** - get an overview over all posibilities of the lib and see how to get the best out of it
                   DESC

  s.homepage     = "https://github.com/Eldorado234/PAYFormBuilder"
  s.screenshots  = ["https://raw.githubusercontent.com/Eldorado234/PAYFormBuilder/master/Images/registrationForm3.png",
                    "https://raw.githubusercontent.com/Eldorado234/PAYFormBuilder/master/Images/controls.png", 
                    "https://raw.githubusercontent.com/Eldorado234/PAYFormBuilder/master/Images/controls2.png"]

  s.license        = 'MIT'
  s.author         = { "Simon Seyer" => "simon.seyer@gmail.com" }
  s.platform       = :ios, '8.0'

  s.source         = { :git => "https://github.com/Eldorado234/PAYFormBuilder.git", :tag => s.version.to_s }
  s.source_files   = 'PAYFormBuilder/**/*.{h,m}'
  s.private_header_files = "PAYFormBuilder/**/*_protected.h", "PAYFormBuilder/privateProtocols/*.h", "PAYFormBuilder/**/*Protected.h"

  s.requires_arc   = true
  s.ios.frameworks = "UIKit"

  s.dependency 'SZTextView',   '~> 1.1'
end
