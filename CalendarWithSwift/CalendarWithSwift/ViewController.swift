//
//  ViewController.swift
//  CalendarWithSwift
//
//  Created by YuChen Hsu on 2019/7/22.
//  Copyright © 2019 YuChen Hsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CalendarVCDelegate {
    func calendarDidSelect(_ date: Date, calendarType: CalendarType) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: date)
        
        switch calendarType {
        case .Start:
            startDateLabel.text = dateString
            break
            
        case .End:
            endDateLabel.text = dateString
            break
            
        default: break
            
        }
    }
    
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func openCalendarAction(_ sender: Any) {
        
        let btn:UIButton = sender as! UIButton
        
        let calendarVC:CalendarViewController = CalendarViewController.init()
            calendarVC.delegate = self
            calendarVC.calendarType = CalendarType(rawValue: btn.tag)
            calendarVC.modalPresentationStyle = UIModalPresentationStyle.custom
            calendarVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
            self.present(calendarVC, animated: true, completion: nil)
    }
}

