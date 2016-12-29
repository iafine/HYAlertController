//
//  ViewController.swift
//  HYAlertControllerDemo
//
//  Created by work on 2016/11/17.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

struct Constant {
    static let ScreenWidth: CGFloat = UIScreen.main.bounds.width
    static let ScreenHeight: CGFloat = UIScreen.main.bounds.height
    static let cellIdentifier: String = "cell"
    static let cellHeight: CGFloat = 44
}

class ViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: Constant.ScreenWidth,
                                                  height: Constant.ScreenHeight),
                                    style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constant.cellIdentifier)
        return tableView
    }()
    
    lazy var dataArray: [[String]]  = [
        [
            "Alert style without title and message",
            "Alert style with title",
            "Alert style with message",
            "Alert style with title and message",
            "Alert style without action",
            "Alert style with image action"
        ],
        [
            "Sheet style without title and message",
            "Sheet style with title",
            "Sheet style with message",
            "Sheet style with title and message",
            "Sheet style without action",
            "Sheet style with image action"
        ],
        [
            "Share style with one line",
            "Share style with multi line",
            "Share style with title",
            "Share style with message",
            "Share style with title and message"
        ]
    ]
}

// MARK: - LifeCycle
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "HYAlertControllerDemo"
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(self.tableView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray[section].count
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
        let str = "show" + dataArray[indexPath.section][indexPath.row].camelcaseStr
        print(str, "🍀")
        perform(Selector(str))
    }
}

extension String {
    var camelcaseStr: String {
        let source = self
        if source.characters.contains(" ") {
            let first = source.substring(to: source.index(source.startIndex, offsetBy: 1))
            let cammel = source.capitalized.replacingOccurrences(of: " ", with: "")
            let rest = String(cammel.characters.dropFirst())
            return "\(first)\(rest)"
        } else {
            let first = source.lowercased().substring(to: source.index(source.startIndex, offsetBy: 1))
            let rest = String(source.characters.dropFirst())
            return "\(first)\(rest)"
        }
    }
}

// MARK: - AlertDemo
extension ViewController {
    func showAlertStyleWithoutTitleAndMessage() {
        let alertVC = HYAlertController(title: nil, message: nil, style: .alert)
        let oneAction = HYAlertAction(title: "One Action", style: .normal, handler: { (action) in
            print(action.title as Any)
        })
        let twoAction = HYAlertAction(title: "Two Action", style: .normal, handler: { (action) in
            print(action.title as Any)
        })
        let threeAction = HYAlertAction(title: "Three Action", style: .destructive, handler: { (action) in
            print(action.title as Any)
        })
        let cancelAction = HYAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            print(action.title as Any)
        })
        
        alertVC.add(cancelAction)
        alertVC.add(oneAction)
        alertVC.add(twoAction)
        alertVC.add(threeAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func showAlertStyleWithTitle() {
        let alertVC = HYAlertController(title: "Title", message: nil, style: .alert)
        let oneAction = HYAlertAction(title: "One Action", style: .normal, handler: { (action) in
            print(action.title as Any)
        })
        let twoAction = HYAlertAction(title: "Two Action", style: .normal, handler: { (action) in
            print(action.title as Any)
        })
        let threeAction = HYAlertAction(title: "Three Action", style: .destructive, handler: { (action) in
            print(action.title as Any)
        })
        let cancelAction = HYAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            print(action.title as Any)
        })
        alertVC.add(oneAction)
        alertVC.add(twoAction)
        alertVC.add(threeAction)
        alertVC.add(cancelAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    func showAlertStyleWithMessage() {
        let alertVC = HYAlertController(title: nil, message: "Here you can describe the details of its title, and you can write here what you want to express.", style: .alert)
        let oneAction = HYAlertAction(title: "One Action", style: .normal, handler: { (action) in
            print(action.title as Any)
        })
        let twoAction = HYAlertAction(title: "Two Action", style: .normal, handler: { (action) in
            print(action.title as Any)
        })
        let threeAction = HYAlertAction(title: "Three Action", style: .destructive, handler: { (action) in
            print(action.title as Any)
        })
        let cancelAction = HYAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            print(action.title as Any)
        })
        alertVC.add(oneAction)
        alertVC.add(twoAction)
        alertVC.add(threeAction)
        alertVC.add(cancelAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    func showAlertStyleWithTitleAndMessage() {
        let alertVC = HYAlertController(title: "Title", message: "Here you can describe the details of its title, and you can write here what you want to express.", style: .alert)
        let oneAction = HYAlertAction(title: "One Action", style: .normal, handler: { (action) in
            print(action.title as Any)
        })
        let twoAction = HYAlertAction(title: "Two Action", style: .normal, handler: { (action) in
            print(action.title as Any)
        })
        let threeAction = HYAlertAction(title: "Three Action", style: .destructive, handler: { (action) in
            print(action.title as Any)
        })
        let cancelAction = HYAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            print(action.title  as Any)
        })
        alertVC.add(oneAction)
        alertVC.add(twoAction)
        alertVC.add(threeAction)
        alertVC.add(cancelAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func showAlertStyleWithoutAction() {
        let alertVC = HYAlertController(title: "Title", message: "Here you can describe the details of its title, and you can write here what you want to express.", style: .alert)
        let cancelAction = HYAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            print(action.title as Any)
        })
        
        alertVC.add(cancelAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func showAlertStyleWithImageAction() {
        let alertVC = HYAlertController(title: "Title", message: "Here you can describe the details of its title, and you can write here what you want to express.", style: .alert)
        let oneAction = HYAlertAction(title: "Facebook Action", image: UIImage(named: "facebook")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let twoAction = HYAlertAction(title: "Twitter Action", image: UIImage(named: "twitter")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let threeAction = HYAlertAction(title: "Snapchat Action", image: UIImage(named: "snapchat")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let cancelAction = HYAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            print(action.title as Any)
        })
        
        alertVC.add(cancelAction)
        alertVC.add(oneAction)
        alertVC.add(twoAction)
        alertVC.add(threeAction)
        self.present(alertVC, animated: true, completion: nil)
    }
}

// MARK: - SheetDemo
extension ViewController {
    func showSheetStyleWithoutTitleAndMessage() {
        let alertVC = HYAlertController(title: nil, message: nil, style: .actionSheet)
        let oneAction = HYAlertAction(title: "One Action", style: .normal, handler: { (action) in
            print(action.title as Any)
        })
        let twoAction = HYAlertAction(title: "Two Action", style: .normal, handler: { (action) in
            print(action.title as Any)
        })
        let threeAction = HYAlertAction(title: "Three Action", style: .destructive, handler: { (action) in
            print(action.title as Any)
        })
        let cancelAction = HYAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            print(action.title as Any)
        })
        alertVC.add(oneAction)
        alertVC.add(twoAction)
        alertVC.add(threeAction)
        alertVC.add(cancelAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func showSheetStyleWithTitle() {
        let alertVC: HYAlertController = HYAlertController(title: "Title", message: nil, style: .actionSheet)
        let oneAction = HYAlertAction(title: "One Action", style: .normal, handler: { (action) in
            print(action.title as Any)
        })
        let twoAction = HYAlertAction(title: "Two Action", style: .normal, handler: { (action) in
            print(action.title as Any)
        })
        let threeAction = HYAlertAction(title: "Three Action", style: .destructive, handler: { (action) in
            print(action.title as Any)
        })
        let cancelAction = HYAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            print(action.title as Any)
        })
        alertVC.add(oneAction)
        alertVC.add(twoAction)
        alertVC.add(threeAction)
        alertVC.add(cancelAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func showSheetStyleWithMessage() {
        let alertVC: HYAlertController = HYAlertController(title: nil, message: "Here you can describe the details of its title, and you can write here what you want to express.", style: .actionSheet)
        let oneAction = HYAlertAction(title: "One Action", style: .normal, handler: { (action) in
            print(action.title as Any)
        })
        let twoAction = HYAlertAction(title: "Two Action", style: .normal, handler: { (action) in
            print(action.title as Any)
        })
        let threeAction = HYAlertAction(title: "Three Action", style: .destructive, handler: { (action) in
            print(action.title as Any)
        })
        let cancelAction = HYAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            print(action.title as Any)
        })
        alertVC.add(oneAction)
        alertVC.add(twoAction)
        alertVC.add(threeAction)
        alertVC.add(cancelAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func showSheetStyleWithTitleAndMessage() {
        let alertVC = HYAlertController(title: "Title", message: "Here you can describe the details of its title, and you can write here what you want to express.", style: .actionSheet)
        let oneAction = HYAlertAction(title: "One Action", style: .normal, handler: { (action) in
            print(action.title as Any)
        })
        let twoAction = HYAlertAction(title: "Two Action", style: .normal, handler: { (action) in
            print(action.title as Any)
        })
        let threeAction = HYAlertAction(title: "Three Action", style: .destructive, handler: { (action) in
            print(action.title as Any)
        })
        let cancelAction = HYAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            print(action.title as Any)
        })
        alertVC.add(oneAction)
        alertVC.add(twoAction)
        alertVC.add(threeAction)
        alertVC.add(cancelAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func showSheetStyleWithoutAction() {
        let alertVC: HYAlertController = HYAlertController(title: "Title", message: "Here you can describe the details of its title, and you can write here what you want to express.", style: .actionSheet)
        let cancelAction = HYAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            print(action.title as Any)
        })
        
        alertVC.add(cancelAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func showSheetStyleWithImageAction() {
        let alertVC: HYAlertController = HYAlertController(title: "Title", message: "Here you can describe the details of its title, and you can write here what you want to express.", style: .actionSheet)
        let oneAction = HYAlertAction(title: "Facebook Action", image: UIImage(named: "facebook")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let twoAction = HYAlertAction(title: "Twitter Action", image: UIImage(named: "twitter")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let threeAction = HYAlertAction(title: "Snapchat Action", image: UIImage(named: "snapchat")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        alertVC.add(oneAction)
        alertVC.add(twoAction)
        alertVC.add(threeAction)
        self.present(alertVC, animated: true, completion: nil)
    }
}

// MARK: - ShareDemo
extension ViewController {
    func showShareStyleWithOneLine() {
        let alertVC: HYAlertController = HYAlertController(title: nil, message: nil, style: .shareSheet)
        let oneAction = HYAlertAction(title: "Facebook", image: UIImage(named: "facebook")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let twoAction = HYAlertAction(title: "Twitter", image: UIImage(named: "twitter")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let threeAction = HYAlertAction(title: "Snapchat", image: UIImage(named: "snapchat")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let fourAction = HYAlertAction(title: "Instagram", image: UIImage(named: "instagram")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let fiveAction = HYAlertAction(title: "Pinterest", image: UIImage(named: "pinterest")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let sixAction = HYAlertAction(title: "Line", image: UIImage(named: "line")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        
        alertVC.addShare([oneAction, twoAction, threeAction, fourAction, fiveAction, sixAction])
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func showShareStyleWithMultiLine() {
        let alertVC: HYAlertController = HYAlertController(title: nil, message: nil, style: .shareSheet)
        let facebookAction = HYAlertAction(title: "Facebook", image: UIImage(named: "facebook")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let twitterAction = HYAlertAction(title: "Twitter", image: UIImage(named: "twitter")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let snapchatAction = HYAlertAction(title: "Snapchat", image: UIImage(named: "snapchat")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let instagramAction = HYAlertAction(title: "Instagram", image: UIImage(named: "instagram")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let pinterestAction = HYAlertAction(title: "Pinterest", image: UIImage(named: "pinterest")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let lineAction = HYAlertAction(title: "Line", image: UIImage(named: "line")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        
        let wechatAction = HYAlertAction(title: "Wechat", image: UIImage(named: "wechat")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let momentAction = HYAlertAction(title: "Moment", image: UIImage(named: "wechat_moment")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let qqAction = HYAlertAction(title: "QQ", image: UIImage(named: "qq")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let qzoneAction = HYAlertAction(title: "Qzone", image: UIImage(named: "qzone")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let sinaAction = HYAlertAction(title: "Sina", image: UIImage(named: "sina")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let alipayAction = HYAlertAction(title: "Alipay", image: UIImage(named: "alipay")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        
        alertVC.addShare( [facebookAction, twitterAction, snapchatAction, instagramAction, pinterestAction, lineAction])
        alertVC.addShare( [wechatAction, momentAction, qqAction, qzoneAction, sinaAction, alipayAction])
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func showShareStyleWithTitle() {
        let alertVC: HYAlertController = HYAlertController(title: "Title", message: nil, style: .shareSheet)
        let facebookAction = HYAlertAction(title: "Facebook", image: UIImage(named: "facebook")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let twitterAction = HYAlertAction(title: "Twitter", image: UIImage(named: "twitter")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let snapchatAction = HYAlertAction(title: "Snapchat", image: UIImage(named: "snapchat")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let instagramAction = HYAlertAction(title: "Instagram", image: UIImage(named: "instagram")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let pinterestAction = HYAlertAction(title: "Pinterest", image: UIImage(named: "pinterest")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let lineAction = HYAlertAction(title: "Line", image: UIImage(named: "line")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        
        let wechatAction = HYAlertAction(title: "Wechat", image: UIImage(named: "wechat")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let momentAction = HYAlertAction(title: "Moment", image: UIImage(named: "wechat_moment")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let qqAction = HYAlertAction(title: "QQ", image: UIImage(named: "qq")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let qzoneAction = HYAlertAction(title: "Qzone", image: UIImage(named: "qzone")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let sinaAction = HYAlertAction(title: "Sina", image: UIImage(named: "sina")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let alipayAction = HYAlertAction(title: "Alipay", image: UIImage(named: "alipay")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        
        alertVC.addShare( [facebookAction, twitterAction, snapchatAction, instagramAction, pinterestAction, lineAction])
        alertVC.addShare( [wechatAction, momentAction, qqAction, qzoneAction, sinaAction, alipayAction])
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func showShareStyleWithMessage() {
        let alertVC: HYAlertController = HYAlertController(title: nil, message: "Here you can describe the details of its title, and you can write here what you want to express.", style: .shareSheet)
        let facebookAction = HYAlertAction(title: "Facebook", image: UIImage(named: "facebook")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let twitterAction = HYAlertAction(title: "Twitter", image: UIImage(named: "twitter")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let snapchatAction = HYAlertAction(title: "Snapchat", image: UIImage(named: "snapchat")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let instagramAction = HYAlertAction(title: "Instagram", image: UIImage(named: "instagram")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let pinterestAction = HYAlertAction(title: "Pinterest", image: UIImage(named: "pinterest")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let lineAction = HYAlertAction(title: "Line", image: UIImage(named: "line")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        
        let wechatAction = HYAlertAction(title: "Wechat", image: UIImage(named: "wechat")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let momentAction = HYAlertAction(title: "Moment", image: UIImage(named: "wechat_moment")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let qqAction = HYAlertAction(title: "QQ", image: UIImage(named: "qq")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let qzoneAction = HYAlertAction(title: "Qzone", image: UIImage(named: "qzone")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let sinaAction = HYAlertAction(title: "Sina", image: UIImage(named: "sina")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let alipayAction = HYAlertAction(title: "Alipay", image: UIImage(named: "alipay")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        
        alertVC.addShare( [facebookAction, twitterAction, snapchatAction, instagramAction, pinterestAction, lineAction])
        alertVC.addShare( [wechatAction, momentAction, qqAction, qzoneAction, sinaAction, alipayAction])
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func showShareStyleWithTitleAndMessage() {
        let alertVC = HYAlertController(title: "Title", message: "Here you can describe the details of its title, and you can write here what you want to express.", style: .shareSheet)
        let facebookAction = HYAlertAction(title: "Facebook", image: UIImage(named: "facebook")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let twitterAction = HYAlertAction(title: "Twitter", image: UIImage(named: "twitter")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let snapchatAction = HYAlertAction(title: "Snapchat", image: UIImage(named: "snapchat")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let instagramAction = HYAlertAction(title: "Instagram", image: UIImage(named: "instagram")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let pinterestAction = HYAlertAction(title: "Pinterest", image: UIImage(named: "pinterest")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let lineAction = HYAlertAction(title: "Line", image: UIImage(named: "line")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        
        let wechatAction = HYAlertAction(title: "Wechat", image: UIImage(named: "wechat")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let momentAction = HYAlertAction(title: "Moment", image: UIImage(named: "wechat_moment")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let qqAction = HYAlertAction(title: "QQ", image: UIImage(named: "qq")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let qzoneAction = HYAlertAction(title: "Qzone", image: UIImage(named: "qzone")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let sinaAction = HYAlertAction(title: "Sina", image: UIImage(named: "sina")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        let alipayAction = HYAlertAction(title: "Alipay", image: UIImage(named: "alipay")!, style: .normal, handler: {
            (action) in
            print(action.title as Any)
        })
        
        alertVC.addShare( [facebookAction, twitterAction, snapchatAction, instagramAction, pinterestAction, lineAction])
        alertVC.addShare( [wechatAction, momentAction, qqAction, qzoneAction, sinaAction, alipayAction])
        present(alertVC, animated: true, completion: nil)
    }
}
