//
//  ViewController.swift
//  HYAlertControllerDemo
//
//  Created by work on 2016/11/17.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit
import HYAlertController

struct Constant {
    static let ScreenWidth: CGFloat = UIScreen.main.bounds.size.width
    static let ScreenHeight: CGFloat = UIScreen.main.bounds.size.height
    static let cellIdentifier: String = "cell"
    static let cellHeight: CGFloat = 44
}

class ViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView (frame: CGRect (x: 0,
                                                                 y: 0,
                                                                 width: Constant.ScreenWidth,
                                                                 height: Constant.ScreenHeight),
                                                  style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constant.cellIdentifier)
        return tableView
    }()
    
    lazy var dataArray: Array = { () -> [Array<String>] in
        let array: Array = [["Alert style without title and message",
                            "Alert style with title",
                            "Alert style with message",
                            "Alert style with title and message",
                            "Alert style without action",
                            "Alert style with imageAction"],
                            ["Sheet style without title and message",
                             "Sheet style with title",
                             "Sheet style with message",
                             "Sheet style with title and message",
                             "Sheet style without action",
                             "Sheet style with imageAction"],
                            ["Share style with one line",
                             "Share style with multi line",
                             "Share style with title",
                             "Share style with message",
                             "Share style with title and message"]]
        return array
    }()
}

// MARK: - LifeCycle
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "HYAlertControllerDemo"
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(self.tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowArray: Array = self.dataArray[section]
        return rowArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: Constant.cellIdentifier)!
        let rowArray: Array = self.dataArray[indexPath.section]
        cell.textLabel?.text = rowArray[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            // alert style
            switch indexPath.row {
            case 0:
                showAlertStyle()
                break
                
            case 1:
                showAlertStyleWithTitle()
                break
                
            case 2:
                showAlertStyleWithWithMessage()
                break
                
            case 3:
                showAlertStyleWithWithTitleAndMessage()
                break
                
            case 4:
                showAlertStyleWithoutAction()
                break
                
            case 5:
                showAlertStyleWithImageAction()
                break
                
            default:
                break
            }
        }else if indexPath.section == 1 {
            // sheet style
            switch indexPath.row {
            case 0:
                showSheetStyle()
                break
                
            case 1:
                showSheetStyleWithTitle()
                break
                
            case 2:
                showSheetStyleWithWithMessage()
                break
                
            case 3:
                showSheetStyleWithWithTitleAndMessage()
                break
                
            case 4:
                showSheetStyleWithoutAction()
                break
                
            case 5:
                showSheetStyleWithImageAction()
                break
                
            default:
                break
            }
        }else {
            // share style
            switch indexPath.row {
            case 0:
                showShareStyleOneLine()
                break
                
            case 1:
                showShareStyleMultiLine()
                break
                
            case 2:
                showShareStyleWithTitle()
                break
                
            case 3:
                showShareStyleWithMessage()
                break
                
            case 4:
                showShareStyleWithTitleAndMessage()
                break
                
            default:
                break
            }
        }
    }
}

// MARK: - AlertDemo
extension ViewController {
    fileprivate func showAlertStyle() {
        let alertVC: HYAlertController = HYAlertController (title: nil, message: nil, style: .alert)
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
    }
    
    fileprivate func showAlertStyleWithTitle() {
        let alertVC: HYAlertController = HYAlertController (title: "Title", message: nil, style: .alert)
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
    }
    
    fileprivate func showAlertStyleWithWithMessage() {
        let alertVC: HYAlertController = HYAlertController (title: nil, message: "Here you can describe the details of its title, and you can write here what you want to express.", style: .alert)
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
    }
    
    fileprivate func showAlertStyleWithWithTitleAndMessage() {
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
    }
    
    fileprivate func showAlertStyleWithoutAction() {
        let alertVC: HYAlertController = HYAlertController (title: "Title", message: "Here you can describe the details of its title, and you can write here what you want to express.", style: .alert)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    fileprivate func showAlertStyleWithImageAction() {
        let alertVC: HYAlertController = HYAlertController (title: "Title", message: "Here you can describe the details of its title, and you can write here what you want to express.", style: .alert)
        let oneAction: HYAlertAction = HYAlertAction (title: "Facebook Action", image: UIImage (named: "facebook")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let twoAction: HYAlertAction = HYAlertAction (title: "Twitter Action", image: UIImage (named: "twitter")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let threeAction: HYAlertAction = HYAlertAction (title: "Snapchat Action", image: UIImage (named: "snapchat")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        alertVC.addAction(action: oneAction)
        alertVC.addAction(action: twoAction)
        alertVC.addAction(action: threeAction)
        self.present(alertVC, animated: true, completion: nil)
    }
}

// MARK: - SheetDemo
extension ViewController {
    fileprivate func showSheetStyle() {
        let alertVC: HYAlertController = HYAlertController (title: nil, message: nil, style: .actionSheet)
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
    }
    
    fileprivate func showSheetStyleWithTitle() {
        let alertVC: HYAlertController = HYAlertController (title: "Title", message: nil, style: .actionSheet)
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
    }
    
    fileprivate func showSheetStyleWithWithMessage() {
        let alertVC: HYAlertController = HYAlertController (title: nil, message: "Here you can describe the details of its title, and you can write here what you want to express.", style: .actionSheet)
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
    }
    
    fileprivate func showSheetStyleWithWithTitleAndMessage() {
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
    }
    
    fileprivate func showSheetStyleWithoutAction() {
        let alertVC: HYAlertController = HYAlertController (title: "Title", message: "Here you can describe the details of its title, and you can write here what you want to express.", style: .actionSheet)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    fileprivate func showSheetStyleWithImageAction() {
        let alertVC: HYAlertController = HYAlertController (title: "Title", message: "Here you can describe the details of its title, and you can write here what you want to express.", style: .actionSheet)
        let oneAction: HYAlertAction = HYAlertAction (title: "Facebook Action", image: UIImage (named: "facebook")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let twoAction: HYAlertAction = HYAlertAction (title: "Twitter Action", image: UIImage (named: "twitter")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let threeAction: HYAlertAction = HYAlertAction (title: "Snapchat Action", image: UIImage (named: "snapchat")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        alertVC.addAction(action: oneAction)
        alertVC.addAction(action: twoAction)
        alertVC.addAction(action: threeAction)
        self.present(alertVC, animated: true, completion: nil)
    }
}

// MARK: - ShareDemo
extension ViewController {
    fileprivate func showShareStyleOneLine() {
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
    }

    fileprivate func showShareStyleMultiLine() {
        let alertVC: HYAlertController = HYAlertController (title: nil, message: nil, style: .shareSheet)
        let facebookAction: HYAlertAction = HYAlertAction (title: "Facebook", image: UIImage (named: "facebook")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let twitterAction: HYAlertAction = HYAlertAction (title: "Twitter", image: UIImage (named: "twitter")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let snapchatAction: HYAlertAction = HYAlertAction (title: "Snapchat", image: UIImage (named: "snapchat")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let instagramAction: HYAlertAction = HYAlertAction (title: "Instagram", image: UIImage (named: "instagram")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let pinterestAction: HYAlertAction = HYAlertAction (title: "Pinterest", image: UIImage (named: "pinterest")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let lineAction: HYAlertAction = HYAlertAction (title: "Line", image: UIImage (named: "line")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        
        let wechatAction: HYAlertAction = HYAlertAction (title: "Wechat", image: UIImage (named: "wechat")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let momentAction: HYAlertAction = HYAlertAction (title: "Moment", image: UIImage (named: "wechat_moment")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let qqAction: HYAlertAction = HYAlertAction (title: "QQ", image: UIImage (named: "qq")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let qzoneAction: HYAlertAction = HYAlertAction (title: "Qzone", image: UIImage (named: "qzone")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let sinaAction: HYAlertAction = HYAlertAction (title: "Sina", image: UIImage (named: "sina")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let alipayAction: HYAlertAction = HYAlertAction (title: "Alipay", image: UIImage (named: "alipay")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        
        alertVC.addShareActions(actions: [facebookAction, twitterAction, snapchatAction, instagramAction, pinterestAction, lineAction])
        alertVC.addShareActions(actions: [wechatAction, momentAction, qqAction, qzoneAction, sinaAction, alipayAction])
        self.present(alertVC, animated: true, completion: nil)
    }
    
    fileprivate func showShareStyleWithTitle() {
        let alertVC: HYAlertController = HYAlertController (title: "Title", message: nil, style: .shareSheet)
        let facebookAction: HYAlertAction = HYAlertAction (title: "Facebook", image: UIImage (named: "facebook")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let twitterAction: HYAlertAction = HYAlertAction (title: "Twitter", image: UIImage (named: "twitter")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let snapchatAction: HYAlertAction = HYAlertAction (title: "Snapchat", image: UIImage (named: "snapchat")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let instagramAction: HYAlertAction = HYAlertAction (title: "Instagram", image: UIImage (named: "instagram")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let pinterestAction: HYAlertAction = HYAlertAction (title: "Pinterest", image: UIImage (named: "pinterest")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let lineAction: HYAlertAction = HYAlertAction (title: "Line", image: UIImage (named: "line")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        
        let wechatAction: HYAlertAction = HYAlertAction (title: "Wechat", image: UIImage (named: "wechat")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let momentAction: HYAlertAction = HYAlertAction (title: "Moment", image: UIImage (named: "wechat_moment")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let qqAction: HYAlertAction = HYAlertAction (title: "QQ", image: UIImage (named: "qq")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let qzoneAction: HYAlertAction = HYAlertAction (title: "Qzone", image: UIImage (named: "qzone")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let sinaAction: HYAlertAction = HYAlertAction (title: "Sina", image: UIImage (named: "sina")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let alipayAction: HYAlertAction = HYAlertAction (title: "Alipay", image: UIImage (named: "alipay")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        
        alertVC.addShareActions(actions: [facebookAction, twitterAction, snapchatAction, instagramAction, pinterestAction, lineAction])
        alertVC.addShareActions(actions: [wechatAction, momentAction, qqAction, qzoneAction, sinaAction, alipayAction])
        self.present(alertVC, animated: true, completion: nil)
    }
    
    fileprivate func showShareStyleWithMessage() {
        let alertVC: HYAlertController = HYAlertController (title: nil, message: "Here you can describe the details of its title, and you can write here what you want to express.", style: .shareSheet)
        let facebookAction: HYAlertAction = HYAlertAction (title: "Facebook", image: UIImage (named: "facebook")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let twitterAction: HYAlertAction = HYAlertAction (title: "Twitter", image: UIImage (named: "twitter")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let snapchatAction: HYAlertAction = HYAlertAction (title: "Snapchat", image: UIImage (named: "snapchat")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let instagramAction: HYAlertAction = HYAlertAction (title: "Instagram", image: UIImage (named: "instagram")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let pinterestAction: HYAlertAction = HYAlertAction (title: "Pinterest", image: UIImage (named: "pinterest")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let lineAction: HYAlertAction = HYAlertAction (title: "Line", image: UIImage (named: "line")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        
        let wechatAction: HYAlertAction = HYAlertAction (title: "Wechat", image: UIImage (named: "wechat")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let momentAction: HYAlertAction = HYAlertAction (title: "Moment", image: UIImage (named: "wechat_moment")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let qqAction: HYAlertAction = HYAlertAction (title: "QQ", image: UIImage (named: "qq")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let qzoneAction: HYAlertAction = HYAlertAction (title: "Qzone", image: UIImage (named: "qzone")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let sinaAction: HYAlertAction = HYAlertAction (title: "Sina", image: UIImage (named: "sina")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let alipayAction: HYAlertAction = HYAlertAction (title: "Alipay", image: UIImage (named: "alipay")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        
        alertVC.addShareActions(actions: [facebookAction, twitterAction, snapchatAction, instagramAction, pinterestAction, lineAction])
        alertVC.addShareActions(actions: [wechatAction, momentAction, qqAction, qzoneAction, sinaAction, alipayAction])
        self.present(alertVC, animated: true, completion: nil)
    }
    
    fileprivate func showShareStyleWithTitleAndMessage() {
        let alertVC: HYAlertController = HYAlertController (title: "Title", message: "Here you can describe the details of its title, and you can write here what you want to express.", style: .shareSheet)
        let facebookAction: HYAlertAction = HYAlertAction (title: "Facebook", image: UIImage (named: "facebook")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let twitterAction: HYAlertAction = HYAlertAction (title: "Twitter", image: UIImage (named: "twitter")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let snapchatAction: HYAlertAction = HYAlertAction (title: "Snapchat", image: UIImage (named: "snapchat")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let instagramAction: HYAlertAction = HYAlertAction (title: "Instagram", image: UIImage (named: "instagram")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let pinterestAction: HYAlertAction = HYAlertAction (title: "Pinterest", image: UIImage (named: "pinterest")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let lineAction: HYAlertAction = HYAlertAction (title: "Line", image: UIImage (named: "line")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        
        let wechatAction: HYAlertAction = HYAlertAction (title: "Wechat", image: UIImage (named: "wechat")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let momentAction: HYAlertAction = HYAlertAction (title: "Moment", image: UIImage (named: "wechat_moment")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let qqAction: HYAlertAction = HYAlertAction (title: "QQ", image: UIImage (named: "qq")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let qzoneAction: HYAlertAction = HYAlertAction (title: "Qzone", image: UIImage (named: "qzone")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let sinaAction: HYAlertAction = HYAlertAction (title: "Sina", image: UIImage (named: "sina")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        let alipayAction: HYAlertAction = HYAlertAction (title: "Alipay", image: UIImage (named: "alipay")!, style: .normal, handler: {
            (action) in
            print(action.title)
        })
        
        alertVC.addShareActions(actions: [facebookAction, twitterAction, snapchatAction, instagramAction, pinterestAction, lineAction])
        alertVC.addShareActions(actions: [wechatAction, momentAction, qqAction, qzoneAction, sinaAction, alipayAction])
        self.present(alertVC, animated: true, completion: nil)
    }
}

