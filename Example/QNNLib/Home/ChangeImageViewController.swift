//
//  ChangeImageViewController.swift
//  QNNLib_Example
//
//  Created by wdy on 2019/3/25.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import QNNLib

class ChangeImageViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor.white
        
        let url = "https://qsqweb-10000035.image.myqcloud.com/94f0c25b89a30fa6dffeb8f871975adc.png"
        QNNImageLoadTool.qnn_downloadImage(url) { [weak self] (img) in
            guard let `self` = self else { return }
            self.navigationController?.navigationBar.setBackgroundImage(img?.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), resizingMode: .stretch), for: UIBarMetrics.default)
        }
        
    }
    
}
