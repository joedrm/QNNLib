//
//  BroadcasterViewController.swift
//  QNNLib_Example
//
//  Created by wdy on 2019/3/23.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import QNNLib
import Then

class BroadcasterViewController: UIViewController, UpdateTitle {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    let keyboard = KeyboardManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        Broadcaster.register(UpdateTitle.self, observer: self)
        Broadcaster.register(UIKeyboardManage.self, observer: self)
        
        titleLabel = UILabel().then({ (v) in
            self.view.addSubview(v)
            v.snp.makeConstraints({ (make) in
                make.center.equalTo(self.view.snp.center)
            })
            v.textColor = UIColor(hexadecimalString: "333333")
            v.font = UIFont.systemFont(ofSize: 20)
        })
        
        textField = UITextField().then({ (v) in
            self.view.addSubview(v)
            v.snp.makeConstraints({ (make) in
                make.centerX.equalTo(self.view.snp.centerX)
                make.top.equalTo(titleLabel.snp.bottom).offset(20)
                make.size.equalTo(CGSize(width: 200, height: 40))
            })
            v.textColor = UIColor(hexadecimalString: "000000")
            v.font = UIFont.systemFont(ofSize: 15)
            v.borderStyle = .roundedRect
        })
        
        let _ = UIButton(type: .custom).then { (v) in
            self.view.addSubview(v)
            v.snp.makeConstraints({ (make) in
                make.centerX.equalTo(self.view.snp.centerX)
                make.top.equalTo(textField.snp.bottom).offset(20)
                make.size.equalTo(CGSize(width: 100, height: 30))
            })
            v.setBackgroundImage(UIImage.imageWithColor(UIColor(hexString: "FF6300")), for: .normal)
            v.setTitle("更新", for: .normal)
            v.setTitleColor(UIColor.white, for: .normal)
            v.addTarget(self, action: #selector(updateTitle), for: .touchUpInside)
        }
        
        
        view.tapActionsGesture { [weak self] in
            self?.view.endEditing(true)
        }
        
        keyboard.on(event: .willShow) { (options) in
            
            debugPrintOnly(options.animationDuration)
            
            }.on(event: .willHide) { (options) in
                
                debugPrintOnly(options.animationCurve)
                
            }.start()
        
    }
    
    func updateWithNewTitle(title: String) {
        titleLabel.text = title
    }
    
    @objc func updateTitle() {
        //        Broadcaster.notify(UpdateTitle.self) {
        //            $0.updateWithNewTitle(title: self.textField.text ?? "")
        //        }
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.white
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension BroadcasterViewController: UIKeyboardManage {
    func UIKeyboardWillShow(beginFrame: CGRect, endFrame: CGRect) {
        print("beginFrame:\(beginFrame)")
        print("endFrame:\(endFrame)")
    }
}
