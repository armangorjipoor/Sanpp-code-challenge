//
//  DataManager.swift
//  Get_To_Know_SapceX
//
//  Created by Arman Gorj on 6/18/1401 AP.
//

import Foundation
import UIKit

class DataManager {
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    static let shared = DataManager()
    var savedMissions = [MissionDetail]()
    var savedSmallImg = UIImage()
    var savedLargeImg = UIImage()
    
    private init() {
        
    }
    
//    private func load() -> [MissionDetail] {
//
//    }
    
    private func saveMissions() {
        do {
            let data = try encoder.encode(savedMissions)
            saveToDisk(data: data)
        }
        catch {
            
        }
    }
  
    private func saveToDisk(data: Data) {
        let path = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)[0].appendingPathComponent("SavedMissions")
        do {
            try data.write(to: path)
            Util.logDocumentDirectory()
        } catch {
            print("Errorr in saveing")
        }
    }
    
    
    func add(item: MissionDetail) {
        savedMissions.append(item)
        saveMissions()
    }
}
