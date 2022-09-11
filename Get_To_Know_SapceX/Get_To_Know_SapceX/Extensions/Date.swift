//
//  Date.swift
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
    
    static func changeDateFormat(with str: String) -> String {
        let date = getDate(dateString: str)
        let dateFormatter = DateFormatter() ;
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy  HH:mm"
        return dateFormatter.string(from: date)
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
    
    
    static func getTimeInAM_PM(with date : Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en-US")
        formatter.dateFormat = "h:ma"//"hh:mm a"
        let time12 = formatter.string(from: date)
        return time12
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
