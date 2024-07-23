//
//  Favorites.swift
//  Where's Snow?
//
//  Created by Parth Antala on 2024-07-23.
//

import Foundation

@Observable
class Favorites {
    private var resorts: Set<String>
    private let key = "Favorites"
    
    init() {
        
        if let array = UserDefaults.standard.array(forKey: key) as? [String] {
            resorts = Set(array)
        } else {
            resorts = []
        }
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        Save()
    }
    
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        Save()
    }
    
    func Save() {
        UserDefaults.standard.setValue(Array(resorts), forKey: key)
    }
}
