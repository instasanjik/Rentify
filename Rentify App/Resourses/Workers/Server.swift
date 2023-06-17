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
    
    var show = false
    
    static let sharedInstance = Server()
    
    var currencyMultiplyer: Double = 1
    
    var accessToken: String? = nil {
        didSet {
            guard accessToken != nil else { return }
            CacheManager.shared.cacheString(accessToken!, forKey: "accessToken")
        }
    }
    var refreshToken: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTY4NjkwMzU3Mywic3ViIjoiNjQ4MmRmZTViOTc5NWM0YzM3YTdlY2I3In0.X3dyFJnm7QNH35E45d2gDp4nZRZHYCB9e4cuZhO9HFE"
    
    let user: User? = nil
    
    func getNewToken() {
        AF.request(URLs.TOKEN + "?refresh_token=\(refreshToken)",
                   method: .post
        ).responseData { response in
            var resultString = ""
            
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                
                let json = try! JSON(data: response.data!)
                self.accessToken = json["access_token"].stringValue
            } else {
                Logger.log(.error, "\(response.response?.statusCode)")
            }
        }
    }
    
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
            "Authorization" : "Bearer \(accessToken)"
        ]
        print(headers)
        AF.request(URLs.SERVER_IP + "/users/me/", method: .get, headers: headers).responseData { response in
            var resultString = ""
            
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = try! JSON(data: response.data!)
                User.shared.userName = json["first_name"].stringValue
                User.shared.avatarLink = "https://sun9-34.userapi.com/impg/oRYpVlutkxYc2ZCIaBc7T039YJN4ho2MNU7Qvw/uvuRJ0T3e18.jpg?size=1620x2160&quality=95&sign=1225a282ccc277050b612f059f2a36d0&type=album"
                User.shared.email = json["email"].stringValue
                handler()
            } else {
                Logger.log(.error, "\(response.response?.statusCode)")
            }
        }
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
        var s: [RentedPromise] = []
        
        if show {
            
            s = [
                
                RentedPromise(timeLeft: "3 day", previewImageLink: "https://images.pexels.com/photos/189333/pexels-photo-189333.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", additionalInfo: "3-room apartment, 70 sq., 4/10 floor", address: "28/5 st., HC Almaty", region: "Astana, Edil area")
            ]
        } else {
            s = []
        }
        show.toggle()
        
        Timer.scheduledTimer(withTimeInterval: 1.3, repeats: false) { _ in
            handler(
                s
            )
        }
    }
    
    func getAds(type: AdType, handler: @escaping ([Ad])-> Void) {
        AF.request(URLs.GET_ALL_HOUSES, method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                
                // Parse the JSON data
                let ads = json.arrayValue.compactMap { adJSON -> Ad? in
                    guard let adDict = adJSON.dictionary,
                          let type = adDict["propertyType"]?.string?.capitalized,
                          let price = adDict["pricePerNight"]?.int,
                          let beds = adDict["numberOfBedrooms"]?.int,
                          let baths = adDict["numberOfBathrooms"]?.int,
                          let totalArea = adDict["sizeInSqMeters"]?.int,
                          let imageUrl = adDict["image_url"]?.stringValue,
                          let address = adDict["address"]?.stringValue,
                          let id = adDict["id"]?.string else {
                        return nil
                    }
                    
                    return Ad(previewImageLink: imageUrl,
                              type: type,
                              price: "\(price)",
                              rating: "5.0 (0 reviews)",
                              address: address,
                              numberOfBedrooms: "\(beds)",
                              numberOfBathRooms: "\(baths)",
                              area: "\(totalArea)",
                              id: id
                    )
                }
                
                handler(ads)
            case .failure(let error):
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
                
                let landlord: Landlord = Landlord(id:           json["owner"]["landlord_id"].stringValue,
                                                  name:         json["owner"]["first_name"].stringValue,
                                                  surname:      json["owner"]["last_name"].stringValue,
                                                  avatarLink:   "",
                                                  rating:       5.0,
                                                  offersCount:  1,
                                                  email:        "",
                                                  phoneNumber:  json["landlord"]["phone_number"].stringValue)
                
                let houseFull: HouseFull = HouseFull(imageLink:     json["image_url"].stringValue,
                                                     id:            json["id"].stringValue,
                                                     price:         String(json["pricePerNight"].floatValue),
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
    
    func bookNow(id: String, dates: [Date]) {
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer \(accessToken!)"
        ]
        
        let parameters = [
            "from_date": "2023-06-10T10:02:01.477Z",
            "to_date": "2023-06-13T10:02:01.477Z",
        ]
        
        
        AF.request(URLs.BOOK + "\(id)/", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseData { response in
            Logger.log(.error, "\(response.response?.statusCode)")
        }
    }
}
