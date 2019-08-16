//
//  CalendarCollectionViewCell.swift
//  CalendarWithSwift
//
//  Created by YuChen Hsu on 2019/7/22.
//  Copyright © 2019 YuChen Hsu. All rights reserved.
//

import UIKit

enum CalendarCollectionViewCellType: Int {
    case calendarCollectionViewCellTypeForUnable = 1
    case calendarCollectionViewCellTypeForNormal = 2
    case calendarCollectionViewCellTypeForSelected = 3
}

class CalendarCollectionViewCell: UICollectionViewCell {
    var statusType : CalendarCollectionViewCellType = .calendarCollectionViewCellTypeForUnable
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var indicateView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setSelectedState() {
        dateLabel.isHidden = false
        dateLabel.textColor = UIColor.white
        indicateView.isHidden = false
        let width : CGFloat = self.frame.size.width
        indicateView.layer.cornerRadius = width / 2.0
        statusType = .calendarCollectionViewCellTypeForSelected
    }

    func setNormalState() {
        dateLabel.isHidden = false
        dateLabel.textColor = UIColor.black
        indicateView.isHidden = true
        statusType = .calendarCollectionViewCellTypeForNormal
    }
    
    func setEmptyUI() {
        dateLabel.isHidden = true
        indicateView.isHidden = true
    }
    
    func setUnableState() {
        dateLabel.isHidden = false
        dateLabel.textColor = UIColor.lightGray
        indicateView.isHidden = true
        statusType = .calendarCollectionViewCellTypeForUnable
    }
}
