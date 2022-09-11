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
        savedMissions = load()
    }
    
    func load() -> [MissionDetail] {
        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        var getImagePath = paths.appendingPathComponent("SavedMissions")
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: getImagePath))
            let res = try decoder.decode([MissionDetail].self, from: data)
            return res
        } catch {
            return []
        }
    }
    
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
    
    deinit {
        print("Deinit DataManager")
    }
    
    
    /// add saved item in savedMission
    /// - Parameter item: item to be saved
    func add(item: MissionDetail) {
        savedMissions.append(item)
        saveMissions()
    }
    
    /// remove saved item in savedMission
    /// - Parameter item: item to be removed
    func remove(item: MissionDetail) {
        if let index = findRemoveIndex(item: item) {
            savedMissions.remove(at: index)
            saveMissions()
        }
    }
    
    private func findRemoveIndex(item: MissionDetail) -> Int? {
        for (index, item) in savedMissions.enumerated() {
            if item.id == item.id {
                return index
            }
        }
        return nil
    }
}
