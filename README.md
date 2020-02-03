# ImagePicker

[![Platforms](https://img.shields.io/badge/platform-iOS-lightgrey.svg)]()
[![Swift Version](https://img.shields.io/badge/swift-5-brightgreen.svg)](https://developer.apple.com/swift)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)


Simple stylable image picker that works with `Photos` framework.

![Demo gif](https://github.com/achernoprudov/image-picker/blob/master/Resources/picker-demo.gif)

# Usage

To create picker you can use `ImagePickerController` class.
```swift
let imagePickerController = ImagePickerController { (selectedAssets: [PHAsset]?) in
  print("Selected assets: \(selectedAssets.debugDescription)")
}
viewController.present(imagePickerController, animated: true, completion: nil)
 ```
 
To override theme of the `ImagePickerController` you can pass `Theme` in consturctor:
```swift
let theme = Theme(
  font: Theme.Font(
    body: UIFont.preferredFont(forTextStyle: .body)
  ),
  color: Theme.Color(
    navigationBar: .systemGray,
    background: .white,
    foreground: .black,
    foregroundLight: .systemGray,
    accent: .systemBlue,
    selectionStroke: .white,
    selectionShadow: .black
  )
)
   
 let picker = ImagePickerController(theme: theme, handler: onPick(assets:))
```

# Swift Package Manager
The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. It’s integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies.

Once you have your Swift package set up, adding `ImagePicker` as a dependency is as easy as adding it to the dependencies value of your `Package.swift`:

### Swift 5
```
dependencies: [
    .package(url: "https://github.com/achernoprudov/image-picker.git", from: "0.0.2")
]
```
