//
//  Date_UTC+Extension.swift
//
//

import Foundation
extension Date {

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
