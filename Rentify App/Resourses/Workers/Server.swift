//
//  Server.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 12.05.2023.
//

import Foundation
import Alamofire
import Kingfisher
import SwiftyJSON
import CoreLocation

enum AdType {
    case all, houses, aparments, rooms
}

class Server {
    
    static let sharedInstance = Server()
    
    var currencyMultiplyer: Double = 1
    
    var accessToken: String? = nil {
        didSet {
            guard accessToken != nil else { return }
            CacheManager.shared.cacheString(accessToken!, forKey: "accessToken")
        }
    }
    
    let user: User? = nil
    
    func loginUser(login: String, password: String,
                   handler: @escaping (Bool) -> Void) {
        /*
         server responce:
         accessToken = String
         */
        
        let parameters = [
            "username" : login,
            "password" : password
        ]
        
        
        AF.request(URLs.LOGIN,
                   method: .post,
                   parameters: parameters,
                   encoder: URLEncodedFormParameterEncoder(destination: .httpBody)).responseData { response in
            
            var resultString = ""
            
            var json: JSON = .null
            
            if let data = response.data {
                try? json = JSON(data: data)
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                self.accessToken = json["access_token"].stringValue
                handler(true)
                
            } else {
                ProgressHud.showError(withText: "Some error was happened #\(response.response?.statusCode ?? 0)")
            }
        }
    }
    
    func sendReport(reportText text: String) {
        let parameters = [
            "text" : text
        ]
        print(parameters)
        AF.request(URLs.reportProblemAPI,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default
        ).responseData { response in
            var resultString = ""
            
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                ProgressHud.showSuccess(withText: "Thanks you for your feedback!")
            } else {
                Logger.log(.error, "\(response.response?.statusCode)")
            }
        }
    }
    
    func getProfilePageData(handler: @escaping (UIImage?, String) -> Void) {
        getUserData {
            guard let url = URL.init(string: User.shared.avatarLink ?? "") else {
                return handler(nil, User.shared.userName ?? "@undefined")
            }
            let resource = ImageResource(downloadURL: url)
            
            KingfisherManager.shared.retrieveImage(with: url) { result in
                switch result {
                case .success(let value):
                    print("Image: \(value.image). Got from: \(value.cacheType)")
                    handler(value.image, "@\(User.shared.userName ?? "@undefined")")
                case .failure:
                    handler(nil, "@\(User.shared.userName ?? "@undefined")")
                }
            }
        }
    }
    
    func setCurrentCurrency(need: Metric) {
        switch need {
        case .usd:
            currencyMultiplyer = 1
        case .kzt:
            Server.sharedInstance.convertCurrency(amount: 1, from: "USD", to: "KZT") { result in
                switch result {
                case .success(let convertedAmount):
                    Logger.log(.success, String(convertedAmount))
                    self.currencyMultiplyer = convertedAmount
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        case .rub:
            Server.sharedInstance.convertCurrency(amount: 1, from: "USD", to: "RUB") { result in
                switch result {
                case .success(let convertedAmount):
                    self.currencyMultiplyer = convertedAmount
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func getUserData(handler: @escaping () -> Void) {
        guard let accessToken = accessToken else { return }
        let headers: HTTPHeaders = [
            "access_token" : accessToken
        ]
        print(headers)
        
        //        AF.request(URLs.getUserData,
        //                   method: .get,
        //                   parameters: parameters,
        //                   encoding: JSONEncoding.default
        //        ).responseData { response in
        //            var resultString = ""
        //
        //            if let data = response.data {
        //                resultString = String(data: data, encoding: .utf8)!
        //                print(resultString)
        //            }
        //
        //            if response.response?.statusCode == 200 {
        //                ProgressHud.showSuccess(withText: "Thanks you for your feedback!")
        //            } else {
        //                Logger.log(.error, "\(response.response?.statusCode)")
        //            }
        //        }
        User.shared.userName = "instasanjik"
        User.shared.avatarLink = "https://sun9-34.userapi.com/impg/oRYpVlutkxYc2ZCIaBc7T039YJN4ho2MNU7Qvw/uvuRJ0T3e18.jpg?size=1620x2160&quality=95&sign=1225a282ccc277050b612f059f2a36d0&type=album"
        User.shared.email = "koshkarbayev.07@gmail.com"
        handler()
    }
    
    func convertCurrency(amount: Double, from: String, to: String, completion: @escaping (Result<Double, Error>) -> Void) {
        let url = "https://api.apilayer.com/fixer/convert?to=\(to)&from=USD&amount=\(amount)"
        
        let headers: HTTPHeaders = [
            "apikey": "IeyAgQ3DWic1Xfw0yaYHHvgPTqSDnKIO"
        ]
        
        AF.request(url, method: .get, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(_):
                let json = JSON(response.data!)
                print(json)
                let convertedAmount = json["result"].doubleValue
                completion(.success(Double(Int(convertedAmount)/100*100)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getFavorites(handler: @escaping ([FavoritePromise]) -> Void) {
        //        guard let accessToken = accessToken else { return }
        //        let headers: HTTPHeaders = [
        //            "access_token" : accessToken
        //        ]
        //        print(headers)
        
        //        let parameters = [
        //
        //        ]
        
        Timer.scheduledTimer(withTimeInterval: 1.3, repeats: false) { _ in
            handler([
                FavoritePromise(previewLink: "https://images.pexels.com/photos/2134224/pexels-photo-2134224.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                                price: "1200",
                                additionalInfo: "3 room apartments, 120sq., 4/10 floor",
                                address: "Saken Seifullin st., - Republic Avenue, HC “Vernyy”",
                                region: "Asnata, Esil area",
                                landlordPhoneNumber: "77479881965",
                                landlordEmail: "main@mail.com")
            ])
        }
    }
    
    func getRentedPromises(handler: @escaping ([RentedPromise]) -> Void) {
        //        guard let accessToken = accessToken else { return }
        //        let headers: HTTPHeaders = [
        //            "access_token" : accessToken
        //        ]
        //        print(headers)
        
        Timer.scheduledTimer(withTimeInterval: 1.3, repeats: false) { _ in
            handler([])
        }
    }
    
    func getAds(type: AdType, handler: @escaping ([Ad])-> Void) {
        AF.request(URLs.GET_ALL_HOUSES, method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                // Parse the JSON data
                let ads = json.arrayValue.compactMap { adJSON -> Ad? in
                    guard let adDict = adJSON.dictionary,
                          let previewImageLink = adDict["images"]?.array?.first?.string,
                          let type = adDict["overview"]?.string,
                          let price = adDict["price"]?.int,
                          let beds = adDict["beds"]?.int,
                          let baths = adDict["baths"]?.int,
                          let totalArea = adDict["total_area"]?.int else {
                        return nil
                    }
                    
                    return Ad(previewImageLink: previewImageLink,
                              type: type,
                              price: "\(price)",
                              rating: "5.0 (0 reviews)",
                              address: "Arman kala 4, Býhar jyraý 30/2",
                              numberOfBedrooms: "\(beds)",
                              numberOfBathRooms: "\(baths)",
                              area: "\(totalArea)")
                }
                
                handler(ads)
            case .failure(let error):
                // Handle the request error
                print("Error: \(error)")
            }
        }
    }
    
    func likeAd(adID: String) {
        CacheManager.shared.favoritesNeedRequest = true
    }
    
    func unlikeAd(adID: String) {
        CacheManager.shared.favoritesNeedRequest = true
    }
    
    func editUserProfile(user: User, newAvatar: UIImage?, handler: @escaping (Bool) -> Void) {
        if let image = newAvatar {
            uploadImage(image: image) { isSuccess in
                if isSuccess {
                    // avatar uploaded to the server. need to send metadata
                    handler(true)
                } else {
                    handler(false)
                    return
                }
            }
        }
        
        
        let parameters = [
            "username" : user.userName,
            "email" : user.email,
            "metric" : user.metric.getAbbr()
        ]
        
        // upload metadata
        Timer.scheduledTimer(withTimeInterval: 1.3, repeats: false) { _ in
            handler(true)
            return
        }
    }
    
    fileprivate func uploadImage(image: UIImage, handler: @escaping (Bool) -> Void) {
        
    }
    
    func getFullHouse(id: String, handler: @escaping (HouseFull) -> Void) {
        
                AF.request(URLs.GET_HOUSE_BY_ID + id, method: .get).validate().responseJSON { response in
                    switch response.result {
                    case .success(_):
                        let json = JSON(response.data!)
        
                        var busyDates: [Date] = []
                        var imageLinks: [String] = []
                        var facilities: [String] = []
        
                        for facility in json["facilities"].array ?? [] {
                            facilities.append(facility["name"].stringValue)
                        }
        
                        for imageLink in json["image_links"].array ?? [] {
                            imageLinks.append(imageLink.stringValue)
                        }
        
                        for busyDate in json["busy_dates"].array ?? [] {
                            let date = Date(timeStamp: busyDate.stringValue)
                            busyDates.append(date)
                        }
        
                        let location: CLLocation = CLLocation(latitude: json["latitude"].doubleValue,
                                                              longitude: json["longitude"].doubleValue)
        
                        let landlord: Landlord = Landlord(id:           json["landlord"]["landlord_id"].stringValue,
                                                          name:         json["landlord"]["name"].stringValue,
                                                          surname:      json["landlord"]["surname"].stringValue,
                                                          avatarLink:   json["landlord"]["avatar_link"].stringValue,
                                                          rating:       json["landlord"]["rating"].doubleValue,
                                                          offersCount:  json["landlord"]["offers_count"].intValue,
                                                          email:        json["landlord"]["email"].stringValue,
                                                          phoneNumber:  json["landlord"]["phone_number"].stringValue)
        
                        let houseFull: HouseFull = HouseFull(imageLink:     json["preview_link"].stringValue,
                                                             id:            json["id"].stringValue,
                                                             price:         String(json["price"].floatValue),
                                                             reviews:       json["reviews"].stringValue,
                                                             address:       json["address"].stringValue,
                                                             landlord:      landlord,
                                                             overview:      json["overview"].stringValue,
                                                             busyDates:     busyDates,
                                                             facilities:    facilities,
                                                             imageLinks:    imageLinks,
                                                             location:      location)
        
                        handler(houseFull)
                    case .failure(let error):
                        Logger.log(.error, "Error: \(error)")
                    }
                }
    }
}
