//
//  NavigationController.swift
//  QNNLib_Example
//
//  Created by wdy on 2019/3/13.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import QNNLib

class NavigationController: RootNavigationController{//RootNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count >= 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
        
//        if BasicTool.isIPhoneXSeries {
//            if let frame = self.tabBarController?.tabBar.frame {
//                let tabbarH = CGRect(x: frame.origin.x, y: UIScreen.main.bounds.size.height - frame.size.height, width: frame.size.width, height: frame.size.height)
//                self.tabBarController?.tabBar.frame = tabbarH
//            }
//        }
    }

    
    func navigationSideslipGesture(enabel: Bool) {
        //sideslipGesture.isEnabled = enabel
    }
}
