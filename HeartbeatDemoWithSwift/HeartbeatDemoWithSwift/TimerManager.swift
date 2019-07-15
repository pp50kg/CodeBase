//
//  TimerManager.swift
//  HeartbeatDemoWithSwift
//
//  Created by YuChen Hsu on 2019/7/12.
//  Copyright © 2019 YuChen Hsu. All rights reserved.
//

import UIKit

private var timeCount = 0

class TimerManager: NSObject {
    static let shared: TimerManager = TimerManager()
    var timer : Timer?
    var alertController : UIAlertController?
    
    private override init() {
    }
    
    func startTimer() -> () {
        timeCount = 10
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction(_:)), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    func resetTimer() -> () {
        timer?.invalidate()
    }
    
    @objc func timerAction(_ inputTimer: Timer) {
        
        // \強制把()內的東西轉成string
        let message: String = "閒置\(timeCount)"
        //swift版本的stringWithFormat
//        let messageStr : String = String(format: "%d", timeCount)
        print(message)
        
        if timeCount % 5 == 0 ,timeCount != 0 {
            
             alertController = UIAlertController(
                title: "登出",
                message: message,
                preferredStyle: .alert
            )
            //isAction block傳入值等同以前的action sender
            //[weak self]如果block內要使用self要先宣告[weak self]
//            let action: UIAlertAction = UIAlertAction(title: "確認", style: .cancel) { [weak self] (isAction) in
//
//            }
//            alertController.addAction(action)
 
            let cancelAction : UIAlertAction = UIAlertAction(title: "確認", style: .cancel, handler: nil)
            
            alertController?.addAction(cancelAction)
            
            let mainVC = UIApplication.shared.keyWindow?.rootViewController
            
            mainVC?.present(alertController!, animated: true, completion: nil)
        }
        
        if timeCount == 0 {
            alertController?.dismiss(animated: true, completion: {
                self.resetTimer()
            })
        } else {
            timeCount -= 1
        }
    }
}
