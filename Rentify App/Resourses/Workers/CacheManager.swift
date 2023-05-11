//
//  CacheManager.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 12.05.2023.
//

import Foundation

class CacheManager {
    static let shared = CacheManager()
    
    private let userDefaults: UserDefaults
    
    private init() {
        userDefaults = UserDefaults.standard
    }
    
    func cacheString(_ value: String, forKey key: String) {
        userDefaults.set(value, forKey: key)
    }
    
    func getString(forKey key: String) -> String? {
        return userDefaults.string(forKey: key)
    }
    
    func removeString(forKey key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
