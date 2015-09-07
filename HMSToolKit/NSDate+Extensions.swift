//
//  NSDate+Extensions.swift
//  HMSToolKit
//
//  Created by chrifpa on 15-09-07.
//  Copyright © 2015 Hackmops. All rights reserved.
//

import UIKit

public extension NSDate {
    static func today() -> NSDate {
        return NSDate().normalizedDateNoon()
    }

    func normalizedDateNoon() -> NSDate {
        let cal = NSCalendar.currentCalendar()
        let components = cal.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year], fromDate: self)
        components.hour = 12
        components.minute = 0
        components.second = 0
        return cal.dateFromComponents(components)!
    }
}
