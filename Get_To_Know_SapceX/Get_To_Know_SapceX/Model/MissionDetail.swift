//
//  MissionDetail.swift
//  Get_To_Know_SapceX
//
//  Created by Arman Gorj on 6/18/1401 AP.
//

import Foundation

class MissionDetail {
    var mission: Mission.Doc
    var satelliteName: String
    var id: String
    var detail: String
    
    init(mission: Mission.Doc) {
        self.mission = mission
        self.satelliteName = mission.name
        self.id = mission.id
        self.detail = mission.details ?? "No avaialbel detail"
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
}
