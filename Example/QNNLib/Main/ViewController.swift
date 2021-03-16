//
//  ViewController.swift
//  QNNLib
//
//  Created by joewang on 12/28/2018.
//  Copyright (c) 2018 joewang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = UIColor(hexadecimalString: "333333")
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(hexadecimalString: "333333"),
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

