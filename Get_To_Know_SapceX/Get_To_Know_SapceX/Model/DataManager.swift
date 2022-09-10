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
    
    let shared = DataManager()
    var savedMissions = [Mission.Doc]()
    var savedSmallImg = UIImage()
    var savedLargeImg = UIImage()
    
    private init() {
        
    }
    
    private func load() -> [MissionOffline] {
        
    }
    
    private func saveMissions() {
        do {
            let data = try encoder.encode(savedMissions)
            saveToDisk(data: data)
        }
        catch {
            
        }
    }
    
    private func saveImages() {
       // save
    }
    
    private func saveToDisk(data: Data) {
        
    }
    
    func add(item: MissionDetail, smallImg: UIImage, largeImg: UIImage) {
        
    }
}
