# HYAlertController
  
 
  [![Language](https://img.shields.io/badge/Swift-3.0-orange.svg)]()
  [![GitHub license](https://img.shields.io/cocoapods/l/HYAlertController.svg)](https://github.com/castial/HYAlertController/blob/master/LICENSE)
  [![Pod version](http://img.shields.io/cocoapods/v/HYAlertController.svg)](https://cocoapods.org/pods/HYAlertController)

HYAlertController是一款极简形式的Alert控件，包含多种使用场景，并且拥有和Apple的`UIAlertController`一样的语法，所以您可以轻松地在您自己的app中使用它。

#### Alert Style

<div align="center">
![alert1][/Screenshots/alert1.png]
![alert2][/Screenshots/alert2.png]
</div>

#### Sheet Style

<div align="center">
![sheet1][/Screenshots/sheet1.png]
![sheet2][/Screenshots/sheet2.png]
</div>

#### Share Style

<div align="center">
![share][/Screenshots/share.png]
</div>

## 特性
----------------

- [x] 标题
- [x] 介绍信息(自适应高度)
- [x] 按钮可以带icon显示
- [x] 自带取消按钮
- [x] 新增分享风格
- [x] 点击事件采用闭包语法回调
- [x] 与UIAlertController相同的语法实现
- [x] 支持Swift 3
- [x] Cocoapods
- [ ] Carthage(暂不支持)


## 要求
----------------

- Swift 3
- iOS 10.0+
- Xcode 8+

## CocoaPods
----------------

[CocoaPods](http://cocoapods.org)是iOS最常用的依赖管理工具，您可以用下面的命令安装它:

```bash
$ gem install cocoapods
```

然后在项目根目录创建`Podfile`文件，写入下面内容：

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

pod 'HYAlertController'
```

最后，命令行运行下面命令即可完成安装：

```bash
$ pod install
```

>注意：`HYAlertController`会依赖安装`SnapKit`库，`HYAlertController`所有的自动布局都采用`SnapKit`完成，如果您的项目中也使用到了`SnapKit`，请避免依赖重复。

## 手动安装
----------------

1. 下载该项目文件，将```/HYAlertController```文件夹拖到您的项目中去；
2. 如果您的项目中没有使用`SnapKit`，您还需要安装`SnapKit`，版本是3.0.0+；

>注意：推荐您使用Cocoapods方式安装，这样可以避免繁琐的依赖问题，但是如果您是手动安装的话，一定要保证您的`SnapKit`版本高于3.0.0。

## 用法
----------------
用法类似于`UIAlertController`，不过`HYAlertController`提供了三种风格: Alert、Sheet和Share。

**Alert Style:** 拥有这种风格，您可以居中显示内容，作为提醒用户操作所用的对话框；

**Sheet Style:** 拥有这种风格，您可以在屏幕下方显示内容，和微信、微博等的风格类似，下面会弹出一个对话框，供用户选择；

**Share Style:** 与**Sheet Style**类似，也是下面弹出一个对话框，所不同的是，这种样式可用于分享所用，您可以快速地完成主流分享样式的创建。

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
>查看更多使用场景，请参考`HYAlertControllerDemo`里详细介绍。

## Swift版本要求

`HYAlertController`采用Swift 3开发完成，所以您的Swift版本必须是Swift 3。

## 自定义

`HYAlertController`本身外部并没有提供自定义选择，这和开发者的想法有关，如果您想做一些基本的改变，请下载项目源码，修改[`HY_Constants.swift`](https://github.com/castial/HYAlertController/blob/master/HYAlertController/HY_Constants.swift)文件，这里包含了一些基本的设置常量，修改这里即可完成自定义。  

修改完成之后，可以参照上述手动安装方法将改造后的类库集成到项目中。

## 交流

- 如果您遇到问题或者是需要帮助，可以创建issue，我会第一时间为您解答；
- 如果您需要一些优化，可以创建issue讨论；
- 如果您想提交贡献，请发布一个pull request.

## MIT License
----------------
HYAlertController is available under the MIT license. See the LICENSE file for more info.
