//
//  Date.swift
//
//  Created by iOSDev on 11/18/19.
//  Copyright © 2019 ARS NETWORK (M) SDN BHD. All rights reserved.
//

import Foundation

extension Date {
    
    var dayInYear: Int {
        let cal = Calendar(identifier: .iso8601)
        return cal.ordinality(of: .day, in: .year, for: self)!
    }
    
    var milliseconds:Double {
        return (self.timeIntervalSince1970 * 1000.0).rounded()
    }
    
    init(milliseconds:Double) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    func getCurrentDate() -> String {
        let todaysDate = Date()
        let dateFormatter = DateFormatter() ;
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter.string(from: todaysDate)
    }
    
    static var currentDate: String { // For parameter in extra dose acceptance
        get {
            let dateFormatter = ISO8601DateFormatter() ;
//            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
            return dateFormatter.string(from: Date())
        }
    }
    static func getDate_D_M_Y(date: Date) -> String {
        let dateFormatter = DateFormatter() ;
        dateFormatter.dateFormat = "d,  MMMM, yyyy"
        return dateFormatter.string(from: date)
    }
    
    static func getDate(dateString: String)-> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ"
        let date = dateFormatter.date(from: dateString) ?? Date()
        
        return date
    }
    
    static func getTime(timeString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        let date = dateFormatter.date(from: timeString) ?? Date()
        
        return date
    }
    
    static func getTimeWhitoutSecond(timeString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.date(from: timeString) ?? Date()
        
        return date
    }
    
    static func getGreetingDay() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        let NEW_DAY = 0
        let NOON = 12
        let SUNSET = 18
        let MIDNIGHT = 24
        
        var greetingText = "Hello" // Default greeting text
        switch hour {
        case NEW_DAY..<NOON:
            greetingText = "Good Morning"
        case NOON..<SUNSET:
            greetingText = "Good Afternoon"
        case SUNSET..<MIDNIGHT:
            greetingText = "Good Evening"
        default:
            _ = "Hello"
        }
        
        return greetingText
    }
    
    static func getTimeInAM_PM(with date : Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en-US")
        formatter.dateFormat = "h:ma"//"hh:mm a"
        let time12 = formatter.string(from: date)
        return time12
    }
    
    static func convertDateToAM_PM(with dateStr: String) -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH:mm:ss"
//        let date = dateFormatter.date(from: dateStr) ?? Date()
//
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "en-US")
//        formatter.dateFormat = "h:ma"//"hh:mm a"
//        let time12 = formatter.string(from: date)
        let formatter = DateFormatter()
        formatter.dateFormat = generateProperDateFormat(with: dateStr)
        formatter.calendar = Calendar.current
        let date = formatter.date(from: dateStr)
        
        let formatter2 = DateFormatter()
        formatter2.locale = Locale(identifier: "en-US")
        formatter2.dateFormat = "hh:mma"
        
        return formatter2.string(from: date!)
    }
    
    //when server send date have second, but when user add second does not have second
    private static func generateProperDateFormat(with str: String) -> String {
        if str.count > 6 {
            print("Recieved Date have secnd: 🟢")
            return "hh:mm:ss"
        } else {
            print("Recieved Date does not have secnd: 🔴")
            return "hh:mm"
        }
    }
    
    static var isUserTime24Hour: Bool {
        get {
            let formatter = DateFormatter()
                formatter.locale = Locale.current
                formatter.dateStyle = .none
                formatter.timeStyle = .short

                let dateString = formatter.string(from: Date())
                let amRange = dateString.range(of: formatter.amSymbol)
                let pmRange = dateString.range(of: formatter.pmSymbol)

                return (pmRange == nil && amRange == nil)
        }
    }
    
    static func convertTimeTo24Hour(with time: String) -> String {
        
        if self.isUserTime24Hour {
            print("🕰 User Time IS 24 Format")
            return time
        } else {
            print("🕰 User Time IS 12 Format")
            print("👉Time to 24 \(time)")
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "h:mm a"
//            dateFormatter.dateFormat = "hh:mma"
//            let dateAsString = "6:35 PM"
            let dateAsString = time
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // fixes nil if device time in 24 hour format
            let date = dateFormatter.date(from: dateAsString)

            dateFormatter.dateFormat = "HH:mm:ss"
//            let date = dateFormatter.date(from: time)
//            dateFormatter.dateFormat = "hh:mm:ss"
            print("Ⓜ️\(dateFormatter.string(from: date!))")
            return dateFormatter.string(from: date!)
        }
    }

}
