//
//  UIButton+Extension.swift
//  Levl
//
//  Created by Henry Gorj on 10/28/1400 AP.
//  Copyright © 1400 AP ARS NETWORK (M) SDN BHD. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {

    func activiyIndicator_Start() {
        
        self.clipsToBounds = true
        
        let activityContainerView = UIView()
        activityContainerView.backgroundColor = self.backgroundColor
        activityContainerView.frame = self.bounds
        
        let activiyIndicatior = UIActivityIndicatorView()
        activiyIndicatior.color = .white
        activiyIndicatior.startAnimating()
        activiyIndicatior.center = activityContainerView.center
        
        activityContainerView.addSubview(activiyIndicatior)
        self.addSubview(activityContainerView)
        
    }
    
    func activiyIndicator_Stop() {
        self.clipsToBounds = false
        let activityContainerView = self.subviews.last
        activityContainerView?.removeFromSuperview()

    }
}

