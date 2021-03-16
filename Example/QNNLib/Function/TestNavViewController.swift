//
//  TestNavViewController.swift
//  QNNLib_Example
//
//  Created by joewang on 2019/2/13.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
import QNNLib

class TestNavViewController: UIViewController {
    
    weak var titleLabel: UILabel!
    weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
//        navTintColor = .red
//        navTitleColor = .red
//        barStyle = .black
//        navBackgroundColor = .orange
//        enablePopGesture = true
        
        title = "test1"
        
        titleLabel = UILabel().then({ (v) in
            self.view.addSubview(v)
            v.snp.makeConstraints({ (make) in
                make.center.equalTo(self.view.snp.center)
            })
            v.textColor = UIColor(hexadecimalString: "333333")
            v.font = UIFont.systemFont(ofSize: 20)
        })
        
        imgView = UIImageView().then({ (v) in
            self.view.addSubview(v)
            v.snp.makeConstraints({ (make) in
                make.centerX.equalTo(self.view.snp.centerX)
                make.top.equalTo(titleLabel.snp.bottom).offset(20)
                make.width.equalTo(self.view.snp.width)
            })
        })
        
        DispatchQueue.main.after(5) {
            self.titleLabel.text = "hahahahhahahah"
            let url = "https://qsqweb-10000035.image.myqcloud.com/94f0c25b89a30fa6dffeb8f871975adc.png"
            QNNImageLoadTool.qnn_downloadImage(url) { (img) in
                guard let _ = img else {
                    return
                }
                self.imgView.image = img
            }
        }
    }
    
    deinit {
        debugPrintOnly("\(self) is deinit ......")
    }}
