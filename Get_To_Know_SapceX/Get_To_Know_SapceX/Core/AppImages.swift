//
//  AppImages.swift
//  Get_To_Know_SapceX
//
//  Created by Arman Gorj on 6/20/1401 AP.
//

import Foundation
import UIKit
struct AppImages {
    
    static func image(for type: Images) -> UIImage {
        switch type {
        case .missionPlaceHldr:
            return UIImage(named: "spaceX")!
        case .sattilePlaceHldr:
            return UIImage(named: "MissionPLaceHolder")!
        }
    }
}
    enum Images {
        case missionPlaceHldr
        case sattilePlaceHldr
    }
