//
//  HomeViewController.swift
//  QNNLib_Example
//
//  Created by joewang on 2019/1/30.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Then

enum NavTestCase : String{
    case normal = "normal"
    case changeImage = "changeImage"
    case disable = "disable"
    case scrollView = "scrollView"
    case transparency = "transparency"
    case fullscreen = "fullscreen"
}

class HomeViewController: ViewController {
    
    weak var tableView : UITableView!
    var titles = ["normal", "changeImage", "disable", "scrollView", "transparency", "fullscreen"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.frame, style: .grouped).then({ (v) in
            v.backgroundColor = UIColor(hexadecimalString: "F8F8F8")
//            v.separatorStyle = .none
            v.delegate = self
            v.dataSource = self
            v.estimatedRowHeight = 0
            v.estimatedSectionFooterHeight = 0
            v.estimatedSectionHeaderHeight = 0
            v.showsVerticalScrollIndicator = false
            v.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
            view.addSubview(v)
//            v.qnn.extendToFullScreen(self)
            v.snp.makeConstraints({ (make) in
                make.top.left.bottom.right.equalTo(view)
            })
        })
    }
}


// MARK: - UITableViewDataSource, UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.textLabel?.textColor = UIColor(hexadecimalString: "333333")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let text = titles[indexPath.row]
        switch text {
        case NavTestCase.normal.rawValue:
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.white
            vc.sh_interactivePopMaxAllowedInitialDistanceToLeftEdge = 44.0
            navigationController?.pushViewController(vc, animated: true)
            break
        case NavTestCase.changeImage.rawValue:
            //debugPrint("changeImage")
            let vc = ChangeImageViewController()
            navigationController?.pushViewController(vc, animated: true)
            break
        case NavTestCase.disable.rawValue:
            //debugPrint("disable")
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.white
            vc.sh_interactivePopDisabled = true
            navigationController?.pushViewController(vc, animated: true)
            break
        case NavTestCase.scrollView.rawValue:
            //debugPrint("scrollView")
            let vc = SegmentBarViewController()
            navigationController?.pushViewController(vc, animated: true)
            break
        case NavTestCase.transparency.rawValue:
            //debugPrint("transparency")
            let vc = UserCenterViewController()
            navigationController?.pushViewController(vc, animated: true)
            break
        case NavTestCase.fullscreen.rawValue:
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.white
            vc.title = "全屏右滑返回"
            navigationController?.pushViewController(vc, animated: true)
            break
        default: break
            
        }
    }
}

