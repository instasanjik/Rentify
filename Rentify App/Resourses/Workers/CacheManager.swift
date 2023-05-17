//
//  CacheManager.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 12.05.2023.
//

import Foundation

class CacheManager {
    static let shared = CacheManager()
    
    var favoritesNeedRequest = true {
        didSet {
            Timer.scheduledTimer(withTimeInterval: 60, repeats: false) { _ in
                self.favoritesNeedRequest = true
            }
        }
    }
    var rentedPromisesNeedRequest = true {
        didSet {
            Timer.scheduledTimer(withTimeInterval: 60, repeats: false) { _ in
                self.rentedPromisesNeedRequest = true
            }
        }
    }
    
    var favorites: [FavoritePromise] = []
    var rentedPromises: [RentedPromise] = []
    var ads: [Ad] = []
    
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


