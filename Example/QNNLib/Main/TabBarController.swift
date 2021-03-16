//
//  TabBarController.swift
//  QNNLib_Example
//
//  Created by joewang on 2019/2/22.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import ESTabBarController_swift
import QNNLib

class TabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let v1 = HomeViewController()
        let v2 = FunctionViewController()
        let v3 = SettingViewController()
        
        //self.extendedLayoutIncludesOpaqueBars = true
        tabBar.isTranslucent = false
//        tabBar.barTintColor = UIColor.red
        
//        self.t
//        self.edgesForExtendedLayout = .all
        self.tabBar.backgroundImage = UIImage.imageWithColor(UIColor.white)
        
        v1.tabBarItem = UITabBarItem(title: "首页", image: UIImage(named: "t_home"), selectedImage: UIImage(named: "t_home_selected"))
        v2.tabBarItem = UITabBarItem(title: "功能测试", image: UIImage(named: "t_play"), selectedImage: UIImage(named: "t_play_selected"))
        v3.tabBarItem = UITabBarItem(title: "设置", image: UIImage(named: "t_mine"), selectedImage: UIImage(named: "t_mine_selected"))

        let n1 = NavigationController.init(rootViewController: v1)
        let n2 = NavigationController.init(rootViewController: v2)
        let n3 = NavigationController.init(rootViewController: v3)

        v1.title = "首页"
        v2.title = "功能测试"
        v3.title = "设置"

        self.viewControllers = [n1, n2, n3]
    }
    
}
