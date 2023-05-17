//
//  URLs.swift
//  Sleepmate
//
//  Created by Sanzhar Koshkarbayev on 25.01.2023.
//

import Foundation

class URLs {
    static let reportProblemAPI = "http://192.168.0.169:1234/send"
    
    static let SERVER_IP = "http://192.168.0.169:8135"
    
    static let LOGIN = SERVER_IP + "/auth/sign_in"
    static let SIGN_UP = SERVER_IP + "/auth/sign-up"
    
    static let GET_ALL_HOUSES = SERVER_IP + "/apartments/"
    static let GET_HOUSE_BY_ID = SERVER_IP + "/apartments/"
    
    static let GET_MY_PROFILE = SERVER_IP + "/users/me"
    static let UPLOAD_AVATAR = SERVER_IP + "/users/me/upload"
    static let UPLOAD_PROFILE = SERVER_IP + "/users/me"
}
