//
//  CalendarViewController.swift
//  CalendarWithSwift
//
//  Created by YuChen Hsu on 2019/8/16.
//  Copyright © 2019 YuChen Hsu. All rights reserved.
//

import UIKit

enum CalendarType: Int {
    case Start = 1,
    End
}

protocol CalendarVCDelegate: AnyObject {
    
    func calendarDidSelect(_ date:Date,calendarType:CalendarType)
    
    
}

extension CalendarVCDelegate {
    
    func cancelSelectedDate() {
        
    }
}

class CalendarViewController: UIViewController {
    
    var headerIdentifier : String!
    var cellIdentifier : String!
    var calendarProvider : CalendarProvider!
    var monthsString = [Any]()
    var calendarModels = [Any]()
    var selectedIndexes = [Any]()
    var selectedDate : Date!
    var today = Date.init()
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var containerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var yearLabel: UILabel!
    
    @IBOutlet weak var sundayLabel: UILabel!
    @IBOutlet weak var mondayLabel: UILabel!
    @IBOutlet weak var tuesdayLabel: UILabel!
    @IBOutlet weak var wednesdayLabel: UILabel!
    @IBOutlet weak var thursdayLabel: UILabel!
    @IBOutlet weak var fridayLabel: UILabel!
    @IBOutlet weak var saturdayLabel: UILabel!
    
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var okButton: UIButton!

    weak var delegate : CalendarVCDelegate?
    var calendarType : CalendarType!
    var firstDate : Date!
    var customDuration = [String : AnyHashable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: Override method
    func maxYear() -> NSInteger {
        return NSIntegerMax
    }
    
    func minYear() -> NSInteger {
        return 1975
    }

    func canbeSelectCell(cell:CalendarCollectionViewCell, model:CalendarMonthModel, day:NSInteger) -> CalendarCollectionViewCell {
        cell.isUserInteractionEnabled = true
        cell.setNormalState()
        return cell
    }

    // MARK: UICollectionViewFlowlayoutDelegate
    func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSize(width: calendarCollectionView.frame.size.width, height: 50.0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath) -> CGSize{
        let itemWidth:CGFloat = calendarCollectionView.frame.size.width / 7.0
        
        let itemHeight:CGFloat = itemWidth
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    // MARK: CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath){
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return calendarModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int{
        
        if calendarModels.count == 0 {
            return 0
        }
        
        let monthModel:CalendarMonthModel = calendarModels[section] as! CalendarMonthModel
        
        return monthModel.totalItemCount
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView{
        
        if kind == UICollectionView.elementKindSectionHeader {
            let header:Any = calendarCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier, for: indexPath)
            
            let headerCell:CalendarHeaderCollectionViewCell = header as! CalendarHeaderCollectionViewCell
            
            let month:String = monthsString[indexPath.section] as! String
            
            headerCell.monthLabel.text = month
            
            return headerCell as UICollectionReusableView;
            
        }
        
        return UICollectionReusableView.init()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell:CalendarCollectionViewCell = calendarCollectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CalendarCollectionViewCell
        
        let monthModel:CalendarMonthModel = calendarModels[indexPath.section] as! CalendarMonthModel
        
        let row:NSInteger = indexPath.row
        
        let emptyCount:NSInteger = monthModel.emptyCellCount
        
        cell.dateLabel.text = ""
        
        if row < monthModel.emptyCellCount {
            cell.setEmptyUI()
            cell.isUserInteractionEnabled = false
        }else{
            let dat:NSInteger = indexPath.row - emptyCount + 1
            
            cell.dateLabel.text =
            
        }
//        if (row < monthModel.emptyCellCount) {
//            [cell setEmptyUI];
//            [cell setUserInteractionEnabled:NO];
//        }
//        else {
//            NSInteger day = indexPath.row - emptyCount + 1;
//
//            cell.dateLabel.text = [NSString stringWithFormat:@"%ld", (long)day];
//
//            [self canbeSelectCell:cell monthModel:monthModel day:day];
//            NSDate *dateAtCell = [DateGenerator getDateFromInt:monthModel.year month:monthModel.month day:day];
//
//            //讀取預設日期
//            NSString *dateKey = self.calendarType == Start? @"start":@"end";
//
//            if ([self isEqualDay:dateAtCell CompareDate: customDuration[dateKey]] &&
//                selectedIndexes.count == 0 &&
//                ![selectedIndexes containsObject:indexPath]) {
//                [selectedIndexes removeAllObjects];
//                [selectedIndexes addObject:indexPath];
//            }
//
//            if (cell.statusType == CalendarCollectionViewCellTypeForNormal && [selectedIndexes containsObject:indexPath]) {
//                [cell setSelectedState];
//            }
//        }
//        return cell;
    }
    
    // MARK: Btn Action
    @IBAction func lastYearButtonTapped(_ sender: Any) {
        
        let firstModel:CalendarMonthModel = calendarModels.first as! CalendarMonthModel
        
        var currentYear:NSInteger = firstModel.year
        
//        if <#condition#> {
//            <#code#>
//        }
        
//        CalendarMonthModel *firstModel = [calendarModels firstObject];
//
//        NSInteger currentYear = firstModel.year;
//
//        if (currentYear > [self minYear]) {
//            currentYear -= 1;
//            [self reloadCalendarModels:currentYear];
//        }
        
    }
    
    @IBAction func nextYearButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        

        }
        
    @IBAction func okButtonTapped(_ sender: Any) {

        }
}
