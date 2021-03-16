//
//  FunctionViewController.swift
//  QNNLib_Example
//
//  Created by joewang on 2019/1/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import QNNLib

class FunctionViewController: ViewController {
    
    var tableView : UITableView!
    var items = ["导航栏背景色", "设置导航栏图片", "下一页", "个人中心"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "功能测试"
        
        
//        self.navigationController?.navigationBar.backgroundColor = UIColor.orange
//        self.navigationController?.navigationBar.barTintColor = UIColor.red
        navigationController?.navigationBar.isTranslucent = false // 导航条背景是否透明
//        navigationController?.setBarBackgroundColor(randomColor())
        
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.navigationBar.barStyle = .default
        
        tableView = UITableView(frame: view.frame, style: .plain).then({ (v) in
            v.delegate = self
            v.dataSource = self
            //v.separatorStyle = .none
            v.estimatedRowHeight = 0
            v.estimatedSectionFooterHeight = 0
            v.estimatedSectionHeaderHeight = 0
            v.backgroundColor = UIColor.white
            v.showsVerticalScrollIndicator = false
            v.tableFooterView = UIView()
            v.tableHeaderView = UIView()
            v.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            v.qnn.registerReusableCell(UITableViewCell.self)
            v.qnn.extendToFullScreen(self, true)
            view.addSubview(v)
            v.snp.makeConstraints({ (make) in
                make.top.left.bottom.right.equalTo(view)
            })
        })
    }
    
    
    func setBarImage() {
        let url = "https://qsqweb-10000035.image.myqcloud.com/94f0c25b89a30fa6dffeb8f871975adc.png"
        QNNImageLoadTool.qnn_downloadImage(url) { [weak self] (img) in
            //self?.navBackgroundImage = img
            self?.navigationController?.navigationBar.setBackgroundImage(img?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .stretch), for: UIBarMetrics.default)
        }
        
    }
    
    
    func chageBgColor() {
        self.navigationController?.navigationBar.barTintColor = randomColor()
//        self.navigationController?.navigationBar.backgroundColor = UIColor.orange
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)

//        navBackgroundImage = nil
//        navBackgroundColor = randomColor()
    }
    
    func randomColor() -> UIColor {
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}



extension FunctionViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.qnn.dequeueReusableCell(indexPath: indexPath)
        cell.textLabel?.text = "\(items[indexPath.row]) "
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row > (items.count - 1) {
            debugPrintOnly("item 不存在")
            return
        }
        switch indexPath.row {
        case 0:
            chageBgColor()
        case 1:
            setBarImage()
        case 2:
            let vc = TestNavViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            debugPrintOnly("ProfileViewController")
//            let vc = ProfileViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
        default: break
            
        }
    }
}
