//
//  UserCenterViewController.swift
//  QNNLib_Example
//
//  Created by wdy on 2019/3/25.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class UserCenterViewController: UITableViewController {
    
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var headerView: UIImageView!
    var navTitleView : UIImageView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        title = ""
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        header.addGestureRecognizer(tap)
        
        
        let headerFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.width * 0.75)
        header.frame = headerFrame
        headerView.frame = headerFrame
        navBackgroundColor = .cyan
        navBarAlpha = 0
        navTintColor = .white
        navTitleColor = UIColor(white: 0, alpha: 0)
        navShadowHidden = true
  
    }
    
    @objc func tapAction(){
        print("ssssssssssssssss")
    }
    
    private func adjustHeaderFrame() {
        var imageWidth = view.bounds.width
        var imageHeight = imageWidth * 0.75
        var originY: CGFloat = 0
        let contentOffsetY = tableView.contentOffset.y
        if contentOffsetY < 0 {
            originY += contentOffsetY
            imageHeight -= contentOffsetY
            imageWidth = imageHeight / 0.75
        }
        let headViewFrame = CGRect(x: (view.bounds.width - imageWidth) / 2, y: originY, width: imageWidth, height: imageHeight)
        headerView.frame = headViewFrame
    }
    
    @IBAction func popToRoot(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - UITableViewDelegate, UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "个人中心 \(indexPath.row + 1)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.white
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerHeight = view.bounds.width * 0.75
        let contentOffsetY = scrollView.contentOffset.y
        let progress = min(1, max(0, contentOffsetY / headerHeight))
        if progress < 0.1 {
            barStyle = .black
            navTintColor = .white
            navTitleColor = UIColor(white: 0, alpha: 0)
        } else {
            barStyle = .default
            navTintColor = UIColor(white: 0, alpha: progress)
            navTitleColor = UIColor(white: 0, alpha: progress)
        }
        navBarAlpha = progress
        self.navTitleView?.isHidden = false
        self.navTitleView?.alpha = progress
        adjustHeaderFrame()
    }
    
}
