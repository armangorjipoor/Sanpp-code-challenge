//
//  Data+Extension.swift
//  Levl
//
//  Created by Henry Gorj on 04/04/2022 AP.
//  Copyright © 2022 AP ARS NETWORK (M) SDN BHD. All rights reserved.
//

import Foundation

extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
