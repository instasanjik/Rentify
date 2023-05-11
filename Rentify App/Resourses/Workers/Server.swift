//
//  Server.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 12.05.2023.
//

import Foundation

class User {
    let avatarLink: String? = ""
    let userName: String? = nil
    
}

class Server {
    
    static let sharedInstance = Server()
    
    var accessToken: String? = nil
    var refreshToken: String? = nil {
        didSet {
            guard refreshToken != nil else { return }
            CacheManager.shared.cacheString(refreshToken!, forKey: "refreshToken")
        }
    }
    
    let user: User? = nil
    
    func loginUser(login: String, password: String,
                   handler: @escaping (Bool) -> Void) {
        /*
             server responce:
                accessToken = String
                refreshToken = String
         */
        Timer.scheduledTimer(withTimeInterval: TimeInterval(Float.random(in: 0.1...1.0)),
                             repeats: false) { _ in
            self.accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJPbmxpbmUgSldUIEJ1aWxkZXIiLCJpYXQiOjE2ODM4MzQ1MDEsImV4cCI6MTcxNTM3MDUwMSwiYXVkIjoid3d3LmV4YW1wbGUuY29tIiwic3ViIjoianJvY2tldEBleGFtcGxlLmNvbSIsIkdpdmVuTmFtZSI6IkpvaG5ueSIsIlN1cm5hbWUiOiJSb2NrZXQiLCJFbWFpbCI6Impyb2NrZXRAZXhhbXBsZS5jb20iLCJSb2xlIjpbIk1hbmFnZXIiLCJQcm9qZWN0IEFkbWluaXN0cmF0b3IiXX0.JK4-zXyrgr7hj7HG9DiOHA7XSVdwT5LkihREAr3__Hk"
            self.refreshToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJPbmxpbmUgSldUIEJ1aWxkZXIiLCJpYXQiOjE2ODM4MzQ1MDEsImV4cCI6MTcxNTM3MDUwMSwiYXVkIjoid3d3LmV4YW1wbGUuY29tIiwic3ViIjoianJvY2tldEBleGFtcGxlLmNvbSIsIkdpdmVuTmFtZSI6IkpvaG5ueSIsIlN1cm5hbWUiOiJSb2NrZXQiLCJFbWFpbCI6Impyb2NrZXRAZXhhbXBsZS5jb20iLCJSb2xlIjpbIk1hbmFnZXIiLCJQcm9qZWN0IEFkbWluaXN0cmF0b3IiXX0.MsdCA3kl9cPbOramcIZ984es_4lHTEMMej3KMFtT4Vw"
            handler(true)
        }
    }
}