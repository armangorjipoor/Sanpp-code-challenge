//
//  Date_UTC+Extension.swift
//  Levl
//
//  Created by Henry Gorj on 06/06/2022 AP.
//  Copyright © 2022 AP ARS NETWORK (M) SDN BHD. All rights reserved.
//

import Foundation
extension Date {
//    private static func getCurrentTimeInUTC() -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        dateFormatter.dateFormat = "HH:mm"
//        return "\(dateFormatter.string(from: Date()))"
//    }
    
//    private static func getCurrentTime() -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
//        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//        return "\(dateFormatter.string(from: Date()))"
//    }
    
//   static func getDifferenceFromUTC() -> String {
//        let RFC3339DateFormatter = DateFormatter()
////        RFC3339DateFormatter.locale = Locale(identifier: "en_US_POSIX")
//        RFC3339DateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
//        RFC3339DateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
//        RFC3339DateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//
//        let string1 = getCurrentTime()
//        let date1 = RFC3339DateFormatter.date(from: string1)
//        let string2 = getCurrentTimeInUTC()
//        let date2 = RFC3339DateFormatter.date(from: string2)
//
//        if let d1 = date1, let d2 = date2 {
//            let result = Calendar.current.dateComponents([.year, .hour, .minute], from: d2, to: d1)
//            let houreDiffernce = result.hour!
//            let minutesDiffernce = abs(result.minute!)
//            let diffRes = "\(String(houreDiffernce)):\(minutesDiffernce)"
//
//            return diffRes
//        } else {
//            return "-3"
//        }
//    }
    
       static func getDifferenceFromUTC() -> String {
//           let utc = getUTCTimeInH_M()
//           let current = getCurrentTimeInH_M()
//           
//           let hourDiff =   current.hour - utc.hour
//           let minDiff = abs(current.min - utc.min)
           
           return TimeZone.current.currentTimezoneOffset()
           
       }
    private static func getCurrentTimeInH_M() -> (hour: Int, min: Int) {
        let date = Date()
        let currentCal = Calendar.current
        let hourComp = currentCal.component(Calendar.Component.hour , from: date)
        let minComp = currentCal.component(Calendar.Component.minute , from: date)
        return (hour: hourComp, min: minComp)
    }
    
    private static func getUTCTimeInH_M() -> (hour: Int, min: Int) {
        let date = Date()
        let utc = TimeZone(identifier: "UTC")
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = utc!
        let hourComp = calendar.component(Calendar.Component.hour , from: date)
        let minComp = calendar.component(Calendar.Component.minute , from: date)
        return (hour: hourComp, min: minComp)
    }
    
    func localToUTC(dateStr: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.calendar = Calendar.current
        dateFormatter.timeZone = TimeZone.current
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            dateFormatter.dateFormat = "H:mm:ss"
            
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    func utcToLocal(dateStr: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "h:mm a"
            
            return dateFormatter.string(from: date)
        }
        return nil
    }
}

extension Date {
    // you can create a read-only computed property to return just the nanoseconds from your date time
    var nanosecond: Int { return Calendar.current.component(.hour,  from: self)   }
    // the same for your local time
    var preciseLocalTime: String {
        return Formatter.preciseLocalTime.string(for: self) ?? ""
    }
    // or GMT time
    var preciseGMTTime: String {
        return Formatter.preciseGMTTime.string(for: self) ?? ""
    }
}

extension Formatter {
    // create static date formatters for your date representations
    static let preciseLocalTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        //formatter.dateFormat = "HH:mm:ss.SSS"
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
    static let preciseGMTTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        //        formatter.dateFormat = "HH:mm:ss.SSS"
        formatter.dateFormat = "h:mm a"
        return formatter
    }()
}

extension TimeZone {
    
    func offsetFromUTC() -> String
    {
        let localTimeZoneFormatter = DateFormatter()
        localTimeZoneFormatter.timeZone = self
        localTimeZoneFormatter.dateFormat = "Z"
        return localTimeZoneFormatter.string(from: Date())
    }
    
 
    func currentTimezoneOffset() -> String {
      let timeZoneFormatter = DateFormatter()
      timeZoneFormatter.dateFormat = "ZZZZZ"
      return timeZoneFormatter.string(from: Date())
  }
}
