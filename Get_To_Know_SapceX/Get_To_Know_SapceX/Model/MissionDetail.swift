//
//  MissionDetail.swift
//  Get_To_Know_SapceX
//
//  Created by Arman Gorj on 6/18/1401 AP.
//

import Foundation
import UIKit
import Kingfisher

class MissionDetail: Codable {
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
    
    func set(smallImage: UIImage,and largeImage: UIImage) {
        setSmall(image: smallImage)
        setLarge(image: largeImage)
    }
    
    private func setSmall(image: UIImage) {
        ImageCache.default.store(image, forKey: smallImgName)
    }
    
    func getSmallImage(completion: @escaping (_ image: Result<ImageCacheResult, KingfisherError>)->Void) {
        ImageCache.default.retrieveImage(forKey: smallImgName, options: nil) { image in
            return completion(image)
        }
    }
    
    private func setLarge(image: UIImage) {
        ImageCache.default.store(image, forKey: lareImgName)
    }
    
    func getLargeImage(completion: @escaping (_ image: Result<ImageCacheResult, KingfisherError>)->Void) {
        ImageCache.default.retrieveImage(forKey: lareImgName, options: nil) { image in
            return completion(image)
        }
    }
    
}
