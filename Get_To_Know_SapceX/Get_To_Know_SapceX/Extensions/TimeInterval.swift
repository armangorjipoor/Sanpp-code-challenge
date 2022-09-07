//
//  TimeInterval.swift
//  Soroush
//
//  Created by iosDEV on 10/30/18.
//  Copyright © 2018 ICCNC. All rights reserved.
//

import Foundation

extension TimeInterval {
    // builds string in app's labels format 00:00.0
    func stringFormatted() -> String {
        let interval = self
        let ti = NSInteger(interval)
        
        let ms = Int((interval.truncatingRemainder(dividingBy: 1)) * 1000)
        
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
//        let hours = (ti / 3600)
        
        return String(format: "%0.2d:%0.2d.%0.3d",minutes,seconds,ms)
    }
}
