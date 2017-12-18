//
//  ViewController.swift
//  Algorithm_swift
//
//  Created by Huang Yanan on 2016/11/11.
//  Copyright © 2016年 Huang Yanan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var a = [13, 3, 2, 7, 5, 6, 7, 13, 12, 10]
        
//        a.quickSort()
        print(a.quickSort())
//
//        a.selectorSort()
//        print(a)
//        
//        a.bubbleSort()
//        print(a)
        print(a.optimizeBubbleSort())
        
//        print(a.sorted(by: >))
        
        
    }

}

