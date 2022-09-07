//
//  NavigationBar.swift
//  Soroush
//
//  Created by iosDEV on 10/30/18.
//  Copyright © 2018 ICCNC. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    func setGradientBackground(colors: [UIColor]) {
        
        var updatedFrame = self.bounds
        
        updatedFrame.size.height += 20
        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
        
        self.setBackgroundImage(gradientLayer.creatGradientImage(), for: .default)
        
        
    }
}
