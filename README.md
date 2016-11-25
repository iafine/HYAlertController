# HYAlertController
  
 
  [![Language](https://img.shields.io/badge/Swift-3.0-orange.svg)]()
  [![GitHub license](https://img.shields.io/cocoapods/l/HYAlertController.svg)](https://github.com/castial/HYAlertController/blob/master/LICENSE)
  [![Pod version](http://img.shields.io/cocoapods/v/HYAlertController.svg)](https://cocoapods.org/pods/HYAlertController)

HYAlertController is a minimalist alert control, that contains a variety of usage scenarios. It has the same syntax as Apple's `UIAlertController`, so you can easily use it in your own app.

[**中文说明**](Docs/README_cn.md)

#### Alert Style

<img src="/Screenshots/alert1.png" width=320 alt="Icon"/>
<img src="/Screenshots/alert2.png" width=320 alt="Icon"/>

#### Sheet Style

<img src="/Screenshots/sheet1.png" width=320 alt="Icon"/>
<img src="/Screenshots/sheet2.png" width=320 alt="Icon"/>

#### Share Style

<img src="/Screenshots/share.png" width=320 alt="Icon"/>

## Features

- [x] Title
- [x] Description message(adaptive height)
- [x] Button with icon
- [x] The default has the cancel button
- [x] New share style
- [x] Closure when a button is clicked
- [x] Similar syntax to UIAlertController
- [x] Swift 3 support
- [x] Cocoapods
- [ ] Carthage(not support)


## Requirements

- Swift 3
- iOS 10.0+
- Xcode 8+

## CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

Then create `Podfile` file into your Xcode project, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

pod 'HYAlertController'
```

Finially, you will complete it with the following command:

```bash
$ pod install
```

>Note: `HYAlertController` will rely on the` SnapKit` library installed, and all autolayout into `HYAlertController` Complete with `SnapKit`. If you use `SnapKit` into your project, Please Avoid duplicate dependencies.

## Manually

1. Download and drop ```/HYAlertController``` folder in your project；
2. If your project does not use `SnapKit`, you also need to install` SnapKit`, the version is 3.0.0 +;

>Note: It is recommended that you install using `Cocoapods`, which avoids cumbersome dependencies. If you are installing manually, make sure your version of `SnapKit` is higher than 3.0.0.

## Usage
The usage is very similar to UIAlertController. `HYAlertController` has three styles: Alert, Sheet and Share.

**Alert Style:** with this style, you can center the contents of the display as a reminder to the user operation of the dialog box;

**Sheet Style:** with this style, you can display the contents of the bottom of the screen, the following will pop up a dialog box for the user to select;

**Share Style:** similar to **Sheet Style**, the difference is that this style can be used for sharing, you can quickly complete the creation of mainstream sharing style.

#### Alert Style

```swift
//Work with Swift 3

let alertVC: HYAlertController = HYAlertController (title: "Title", message: "Here you can describe the details of its title, and you can write here what you want to express.", style: .alert)
let oneAction: HYAlertAction = HYAlertAction (title: "One Action", style: .normal, handler:  { (action) in
    print(action.title)
})
let twoAction: HYAlertAction = HYAlertAction (title: "Two Action", style: .normal, handler:  { (action) in
    print(action.title)
})
let threeAction: HYAlertAction = HYAlertAction (title: "Three Action", style: .destructive, handler:  { (action) in
    print(action.title)
})
let cancelAction: HYAlertAction = HYAlertAction (title: "Cancel Action", style: .cancel, handler:  { (action) in
    print(action.title)
})
alertVC.addAction(action: oneAction)
alertVC.addAction(action: twoAction)
alertVC.addAction(action: threeAction)
alertVC.addAction(action: cancelAction)
self.present(alertVC, animated: true, completion: nil)

```

#### Sheet Style

```swift
//Work with Swift 3

let alertVC: HYAlertController = HYAlertController (title: "Title", message: "Here you can describe the details of its title, and you can write here what you want to express.", style: .actionSheet)
let oneAction: HYAlertAction = HYAlertAction (title: "One Action", style: .normal, handler:  { (action) in
    print(action.title)
})
let twoAction: HYAlertAction = HYAlertAction (title: "Two Action", style: .normal, handler:  { (action) in
    print(action.title)
})
let threeAction: HYAlertAction = HYAlertAction (title: "Three Action", style: .destructive, handler:  { (action) in
    print(action.title)
})
let cancelAction: HYAlertAction = HYAlertAction (title: "Cancel Action", style: .cancel, handler:  { (action) in
    print(action.title)
})
alertVC.addAction(action: oneAction)
alertVC.addAction(action: twoAction)
alertVC.addAction(action: threeAction)
alertVC.addAction(action: cancelAction)
self.present(alertVC, animated: true, completion: nil)

```

#### Share Style

```swift
//Work with Swift 3
let alertVC: HYAlertController = HYAlertController (title: nil, message: nil, style: .shareSheet)
let oneAction: HYAlertAction = HYAlertAction (title: "Facebook", image: UIImage (named: "facebook")!, style: .normal, handler: {
            (action) in
    print(action.title)
})
let twoAction: HYAlertAction = HYAlertAction (title: "Twitter", image: UIImage (named: "twitter")!, style: .normal, handler: {
            (action) in
    print(action.title)
})
let threeAction: HYAlertAction = HYAlertAction (title: "Snapchat", image: UIImage (named: "snapchat")!, style: .normal, handler: {
            (action) in
    print(action.title)
})
let fourAction: HYAlertAction = HYAlertAction (title: "Instagram", image: UIImage (named: "instagram")!, style: .normal, handler: {
            (action) in
    print(action.title)
})
let fiveAction: HYAlertAction = HYAlertAction (title: "Pinterest", image: UIImage (named: "pinterest")!, style: .normal, handler: {
            (action) in
    print(action.title)
})
let sixAction: HYAlertAction = HYAlertAction (title: "Line", image: UIImage (named: "line")!, style: .normal, handler: {
            (action) in
    print(action.title)
})
alertVC.addShareActions(actions: [oneAction, twoAction, threeAction, fourAction, fiveAction, sixAction])
self.present(alertVC, animated: true, completion: nil)

```
>For more usage scenarios, please refer to `HYAlertControllerDemo` for details.

## Swift Version

`HYAlertController` is developed with Swift 3, so your Swift version must be Swift 3.

## Custom

`HYAlertController` does not provide customization outside, which is related to the developer's idea. If you want to make some basic changes, download the project source and modify the[`HY_Constants.swift`](https://github.com/castial/HYAlertController/blob/master/HYAlertController/HY_Constants.swift) file, which contains some basic setting constants, modify it.

After modification, you can integrate into your project using the above manual installation method.

## Communicate

- If you need help or you'd like to ask a general question, open an issue;
- If you found a bug, open an issue;
- If you have a feature request, open an issue;
- If you want to contribute, submit a pull request.

## MIT License
HYAlertController is available under the MIT license. See the LICENSE file for more info.
