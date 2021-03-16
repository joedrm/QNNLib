//
//  ProfileViewController.swift
//  HXNavigationController
//
//  Created by HongXiangWen on 2018/12/18.
//  Copyright © 2018年 WHX. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {

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
        
        let imgURL = "https://qsqweb-10000035.image.myqcloud.com/79a24e3a4cccd3dc082786c2b659bb20.png"
        let navTitleView = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 20))
        navTitleView.isHidden = true
        navTitleView.qnn_load(imgURL) { [weak self] (image) in
            guard self != nil else {
                return
            }
            navTitleView.image = image.imageCompressForWidth(targetWidth: 60)
            navTitleView.alpha = 0
        }
        self.navTitleView = navTitleView
        self.navigationItem.titleView = navTitleView
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        self.navTitleView?.frame = CGRect(x: 0, y: 0, width: 60, height: 20)
//    }
    
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


extension UIImage{
    // 图片处理
    // 指定大小缩放图片 返回图片
    
    public func imageCompressForSizeToTargetSize(sourceImage:UIImage,targetSize:CGSize) ->UIImage{
        // 创建新的图片
        var newImage:UIImage = UIImage()
        let imageSize:CGSize = sourceImage.size
        // 旧图片的宽 高
        let width = imageSize.width
        let height = imageSize.height
        //  新图片的宽 高
        let targetWidth = targetSize.width
        let targetHeight = targetSize.height
        // 缩放比例
        var scaleFactor:CGFloat = 0.0
        var scaledWidth = targetWidth
        var scaledHeight = targetHeight
        var thumbnailPoint = CGPoint.zero
        
        
        if imageSize.equalTo(size) {
            return sourceImage
        }else{
            // 缩放比例
            let widthFactor = targetWidth / width
            let heightFactor = targetHeight / height
            if widthFactor > heightFactor {
                // 为了避免图片缩放后被拉伸，缩放比例 按照长的进行计算
                scaleFactor = widthFactor
            }else{
                scaleFactor = heightFactor
            }
            scaledWidth = width * scaleFactor
            scaledHeight = height * scaleFactor
            
            if widthFactor > heightFactor {
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5
            }else{
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5
            }
        }
        
        // 绘制图形
        UIGraphicsBeginImageContext(targetSize)
        var thumbnailRect = CGRect.zero
        thumbnailRect.origin = thumbnailPoint
        thumbnailRect.size.width = scaledWidth
        thumbnailRect.size.height = scaledHeight
        sourceImage.draw(in:thumbnailRect)
        newImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return newImage;
    }
    
    // 指定宽度按比例缩放
    public func imageCompressForWidth( targetWidth:CGFloat) ->UIImage{
        // 创建新的图片
        var newImage:UIImage = UIImage()
        let imageSize:CGSize = self.size
        // 旧图片的宽 高
        let width = imageSize.width
        let height = imageSize.height
        //  新图片的宽 高
        let targetWidth = targetWidth
        let targetHeight = height / width * targetWidth
        let size = CGSize(width: targetWidth, height: targetHeight)
        
        // 缩放比例
        var scaleFactor:CGFloat = 0.0
        var scaledWidth = targetWidth
        var scaledHeight = targetHeight
        var thumbnailPoint = CGPoint.zero
        if imageSize.equalTo(size) {
            let widthFactor = targetWidth / width
            let heightFactor = targetHeight / height
            scaleFactor = widthFactor > heightFactor ? widthFactor : heightFactor
            scaledWidth = width * scaleFactor
            scaledHeight = height * scaleFactor
            if widthFactor > heightFactor {
                thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5
            }else{
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5
            }
        }
        UIGraphicsBeginImageContext(size)
        var thumbnailRect = CGRect.zero
        thumbnailRect.origin = thumbnailPoint
        thumbnailRect.size.width = scaledWidth
        thumbnailRect.size.height = scaledHeight
        self.draw(in:thumbnailRect)
        newImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return newImage
        
    }
    
    
}
