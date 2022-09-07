//
//  NotificationName + Extension.swift
//  Levl
//
//  Created by Henry Gorj on 04/25/2022 AP.
//  Copyright © 2022 AP ARS NETWORK (M) SDN BHD. All rights reserved.
//

import Foundation
import UIKit

extension Notification.Name {
    static let didReceiveData = Notification.Name("didReceiveData")
    static let didProfileChanged = Notification.Name("didProfileChanged")
    static let didMedRoutinChnaged = Notification.Name("didMedRoutinChnaged")
    static let completedLengthyDownload = Notification.Name("completedLengthyDownload")
    static let didReceiveExtraDoseReq = Notification.Name("didReceiveEtraDoseRq")
}
