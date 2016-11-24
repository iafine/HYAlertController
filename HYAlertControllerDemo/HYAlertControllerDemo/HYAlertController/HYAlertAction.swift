//
//  HYAlertAction.swift
//  Quick-Start-iOS
//
//  Created by work on 2016/10/31.
//  Copyright © 2016年 hyyy. All rights reserved.
//

import UIKit

public enum HYAlertActionStyle : Int {
    case normal
    case cancel
    case destructive
}

public typealias actionHandler = (_ action: HYAlertAction) -> Void

public class HYAlertAction: NSObject {
    
    public var title: String
    public var image: UIImage = UIImage ()
    public var style: HYAlertActionStyle
    public var myHandler: actionHandler

    public init(title: String, style: HYAlertActionStyle, handler: @escaping actionHandler) {
        self.title = title
        self.style = style
        self.myHandler = handler
        super.init()
    }
    
    public init(title: String, image: UIImage, style: HYAlertActionStyle, handler: @escaping actionHandler) {
        self.title = title
        self.style = style
        self.image = image
        self.myHandler = handler
        super.init()
    }
}
