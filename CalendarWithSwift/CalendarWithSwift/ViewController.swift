//
//  ViewController.swift
//  CalendarWithSwift
//
//  Created by YuChen Hsu on 2019/7/22.
//  Copyright © 2019 YuChen Hsu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func openCalendarAction(_ sender: Any) {
        
        guard let btn:UIButton = sender as? UIButton else {
            return
        }
//        let calendarVC:CalendarViewController = CalendarViewController.ini
        
//        UIButton *btn = (UIButton *)sender
//        CalendarViewController *calendarVC = [CalendarViewController new];
//        [calendarVC setDelegate:self];
//        [calendarVC setCalendarType:btn.tag];
//        [calendarVC setModalPresentationStyle:UIModalPresentationCustom];
//        [calendarVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//        [self presentViewController:calendarVC animated:YES completion:nil];
    }
    
}

