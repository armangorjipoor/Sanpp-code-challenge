//
//  MissionDetail.swift
//  Get_To_Know_SapceX
//
//  Created by Arman Gorj on 6/18/1401 AP.
//

import Foundation
import UIKit

class MissionDetail {
    var mission: Mission.Doc
    var satelliteName: String
    var id: String
    var detail: String
    var smallImgName: String
    var lareImgName: String
    
    init(mission: Mission.Doc) {
        self.mission = mission
        self.satelliteName = mission.name
        self.id = mission.id
        self.detail = mission.details ?? "No avaiable detail"
        self.smallImgName = mission.links?.patch?.small ?? mission.id
        self.lareImgName = mission.links?.patch?.large ?? (mission.id + "Large")
    }
    
    var wikiURL: URL? {
        get {
            URL(string: mission.links?.wikipedia ?? "")
        }
    }
    
    var videoURL: URL? {
        get {
            URL(string: mission.links?.webcast ?? "")
        }
    }
    
    var largeImgURL: URL? {
        get {
            URL(string: mission.links?.patch?.large ?? "")
        }
    }
    
    func setSmall(image: UIImage) {
        
    }
    
    func getSmallImage() -> UIImage? {
        
    }
    
    func setLarge(image: UIImage) {
        
    }
    
    func getLargeImage() -> UIImage? {
        
    }
}
