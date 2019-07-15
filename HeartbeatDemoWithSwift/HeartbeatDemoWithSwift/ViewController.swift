//
//  ViewController.swift
//  HeartbeatDemoWithSwift
//
//  Created by YuChen Hsu on 2019/7/12.
//  Copyright © 2019 YuChen Hsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TimerManager.shared.startTimer()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetTimer(_ sender: Any) {
        TimerManager.shared.resetTimer()
        TimerManager.shared.startTimer()
    }
}

