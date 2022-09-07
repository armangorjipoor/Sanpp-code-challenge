//
//  UITableView+Extention.swift
//  Levl
//
//  Created by Henry Gorj on 01/03/2022 AP.
//  Copyright © 2022 AP ARS NETWORK (M) SDN BHD. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {

    func setMessage(_ message: String) {
        let lblMessage = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        lblMessage.text = message
        lblMessage.textColor = .black
        lblMessage.numberOfLines = 0
        lblMessage.textAlignment = .center
        lblMessage.font = UIFont(name: "TrebuchetMS", size: 15)
        lblMessage.sizeToFit()

        self.backgroundView = lblMessage
        self.separatorStyle = .none
    }

    func clearBackground() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
