//
//  NavScrollViewController.swift
//  QNNLib_Example
//
//  Created by wdy on 2019/3/25.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import QNNLib

private let segmentBarDefaultHeight = 44

class SegmentBarViewController: ViewController {
    
    lazy var contentView: UIScrollView = {
        let contentView = UIScrollView.init()
        contentView.delegate = self
        contentView.isPagingEnabled = true
        contentView.showsVerticalScrollIndicator = false
        contentView.showsHorizontalScrollIndicator = false
        contentView.bounces = false
        contentView.sh_scrollViewPopGestureRecognizerEnable = true
        return contentView
    }()
    
    lazy var segmentBar: QNNSegmentBar = {
        let seg = QNNSegmentBar.segmentBarWithFrame(frame: CGRect.init(x: 0, y: 0, width: Int(ScreenWidth), height: segmentBarDefaultHeight))
        seg.delegate = self
        seg.updateWithConfig { (config) in
            config?.indicatorLimitW = 40~
            config?.itemNormalColor = UIColor(hexadecimalString: "999999")
            config?.itemSelectColor = UIColor(hexadecimalString: "333333")
            config?.indicatorColor = UIColor(hexadecimalString: "FF4343")
            config?.itemFont = UIFont.systemFont(ofSize: 16)~
        }
        return seg
    }()
    
    var segmentBarHeight : CGFloat {
        get{
            guard segmentBar.items.count > 0 else {
                return 0
            }
            return segmentBar.height
        }
        set{
            guard segmentBar.superview == self.view else {
                return
            }
            segmentBar.height = newValue
            segmentBar.snp.updateConstraints { (make) in
                make.height.equalTo(newValue)
            }
        }
    }
    
    
    var startOffsetX: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "选项卡页面"
        
        view.backgroundColor = UIColor.white
        extendedLayoutIncludesOpaqueBars = true
        if #available(iOS 11.0, *) {
            contentView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        view.addSubview(segmentBar)
        segmentBar.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(TopLayoutDefaultHeight)
            make.height.equalTo(segmentBarDefaultHeight)
        }
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(segmentBar.snp.bottom)
        }
        
        updateChildVCs()
    }
    
    
    /// 子类调用，如果选项卡的标题和个数由服务器返回，则在网络请求返回后调用该方法，刷新选项卡数据
    func updateChildVCs() {
        
        guard let titles = self.childVCTitles() else {
            return
        }
        
        childViewControllers.forEach { vc in
            vc.removeFromParentViewController()
        }
        
        let numbers = titles.count
        for index in 0..<numbers {
            let vc = UIViewController()
            vc.title = titles[index] as String
            addChildViewController(vc)
        }
        
        guard numbers > 0 || numbers == childViewControllers.count else {
            assert(numbers > 0 || numbers == childViewControllers.count, "个数不一致, 请自己检查")
            return
        }
        
        segmentBar.setItems(titles as Array<String>)
        segmentBarHeight = CGFloat((numbers > 0) ? segmentBarDefaultHeight : 0)
        
        contentView.contentSize = CGSize.init(width: CGFloat(childViewControllers.count) * view.width, height: 0)
        segmentBar.selectIndex = 0
    }
    
    /// 子类重写，返回选项卡的标题
    public func childVCTitles() -> [NSString]? {
        return ["哈哈", "哈哈", "哈哈"]
    }
    
    /// 子类重写，返回当前页的控制器
    public func childVCForIndex(index: Int) -> UIViewController? {
        let vc = UIViewController()
        return vc
    }
    
    /// 子类重写，点击选项卡事件
    public func segmentVCSelected(index: Int) {
        
    }
}

extension SegmentBarViewController : UIScrollViewDelegate, QNNSegmentBarDelegate{
    func segmentBarDidSelected(_ segmentBar: QNNSegmentBar, toIndex: Int, fromIndex: Int) {
        startOffsetX = contentView.contentOffset.x
        showChildVCViewsAtIndex(toIndex)
        segmentVCSelected(index: toIndex)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        segmentBar.updateIndicatorView(scrollView, startOffsetX)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = (scrollView.contentOffset.x + scrollView.width * 0.5) / scrollView.width
        segmentBar.scrollToIndex(Int(index))
    }
}

extension SegmentBarViewController {
    
    
    func showChildVCViewsAtIndex(_ toIndex:Int) {
        
        if (self.childViewControllers.count == 0) || (toIndex < 0) || (toIndex > self.childViewControllers.count - 1) {
            return
        }
        
        let vc = self.childViewControllers[toIndex]
        vc.view.frame = CGRect.init(x: CGFloat(toIndex) * contentView.width, y: 0, width: contentView.width, height: contentView.height)
        contentView.addSubview(vc.view)
        contentView.contentOffset = CGPoint(x: CGFloat(toIndex) * contentView.width, y: 0)
    }
}
