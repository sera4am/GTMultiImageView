Pod::Spec.new do |spec|

  spec.name         = "GTMultiImageView"
  spec.version      = "0.0.1"
  spec.summary      = "A simple image views like Twittter"

  spec.description  = <<-DESC
It provides a split ImageView like Twitter.

Easy to use.
Step 1. Place the UIView in your UIViewController.
Step 2. Change the UIView Class to GTMultiImageView.
Step 3. Place the array of UIImage in GTMultiImageView's images property in the code.
                   DESC

  spec.homepage     = "https://github.com/sera4am/GTMultiImageView"
  spec.license      = { :type => "MIT", :file => "LISENCE" }
  spec.author             = { "sera4am" => "sera@4am.jp" }
  spec.platform     = :ios, "11.0"

  spec.source       = { :git => "https://github.com/sera4am/GTMultiImageView.git", :tag => "#{spec.version}" }


  spec.source_files  = "GTCamera", "GTMultiImageView/Classes/*.{swift}"
  spec.requires_arc = true
  spec.swift_version = "5.0"
end
