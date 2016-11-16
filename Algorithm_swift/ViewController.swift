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
        
        var a = [9,3,9,4,6,5]
        
        a.quickSort()
        print(a)
        
        a.selectorSort()
        print(a)
        
        a.bubbleSort()
        print(a)
        
        print(a.sorted(by: >))
        
    }

}

