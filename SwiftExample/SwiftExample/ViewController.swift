//
//  ViewController.swift
//  SwiftExample
//
//  Created by Wenchao Ding on 9/3/15.
//  Copyright (c) 2015 wenchao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {

    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    let datesWithCat = ["20150505","20150605","20150705","20150805","20150905","20151005","20151105","20151205","20160106",
    "20160206","20160306","20160406","20160506","20160606","20160706"]
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.scrollDirection = .Horizontal
        calendar.scope = .Week
        calendar.useStickyMonthLabelsInWeekScope = true
        calendar.appearance.caseOptions = [.HeaderUsesUpperCase,.WeekdayUsesUpperCase]
//        calendar.selectDate(calendar.dateWithYear(2015, month: 10, day: 10))
        calendar.selectDate(NSDate())
//        calendar.allowsMultipleSelection = true
        
        // Uncomment this to test month->week and week->month transition
        /*
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(1.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
            self.calendar.setScope(.Week, animated: true)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(1.5 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) { () -> Void in
                self.calendar.setScope(.Month, animated: true)
            }
        }
        */

    }
    private let monthTimeInterval: NSTimeInterval = 30 * 24 * 60 * 60

    func minimumDateForCalendar(calendar: FSCalendar!) -> NSDate! {
        return NSDate(timeIntervalSinceNow: -monthTimeInterval)
    }
    
    func maximumDateForCalendar(calendar: FSCalendar!) -> NSDate! {
        return NSDate(timeIntervalSinceNow: monthTimeInterval)
    }


    func calendar(calendar: FSCalendar!, hasEventForDate date: NSDate!) -> Bool {
        return calendar.dayOfDate(date) == 5
    }

    func calendarCurrentPageDidChange(calendar: FSCalendar!) {
//        NSLog("change page to \(calendar.stringFromDate(calendar.currentPage))")
    }
    
    func calendar(calendar: FSCalendar!, didSelectDate date: NSDate!) {
        NSLog("calendar did select date \(calendar.stringFromDate(date))")
    }
    
    func calendarCurrentScopeWillChange(calendar: FSCalendar!, animated: Bool) {
        calendarHeightConstraint.constant = calendar.sizeThatFits(CGSizeZero).height
        view.layoutIfNeeded()
    }
    
    func calendar(calendar: FSCalendar!, imageForDate date: NSDate!) -> UIImage! {
        return [13,24].containsObject(calendar.dayOfDate(date)) ? UIImage(named: "icon_cat") : nil
    }
    
}

