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
    
    var accessToken: String? = "nil"
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
        //        guard let accessToken = accessToken else { return }
        //        let headers: HTTPHeaders = [
        //            "access_token" : accessToken
        //        ]
        //        print(headers)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            handler([
                Ad(previewImageLink: "https://images.pexels.com/photos/15409431/pexels-photo-15409431.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                   type: "House",
                   price: "1200",
                   rating: "3.4",
                   address: "Arman Qala 4, Bukhar Zhyrau 30/1",
                   numberOfBedrooms: "3",
                   numberOfBathRooms: "4",
                   area: "130"),
                Ad(previewImageLink: "https://images.pexels.com/photos/15409431/pexels-photo-15409431.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                   type: "House",
                   price: "1200",
                   rating: "3.4",
                   address: "Arman Qala 4, Bukhar Zhyrau 30/1",
                   numberOfBedrooms: "3",
                   numberOfBathRooms: "4",
                   area: "130")
            ])
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
//        guard let accessToken = accessToken else { return }
        let headers: HTTPHeaders = [
            "access_token" : accessToken ?? ""
        ]
        
        let parameters = [
            "apartment_id" : id
        ]
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            handler(HouseFull(imageLink: "https://images.pexels.com/photos/1918291/pexels-photo-1918291.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                              id: "2019302",
                              price: "1920",
                              reviews: "1.4 (1 reviews)",
                              address: "asda",
                              landlord: .init(id: "19293",
                                              name: "Danil",
                                              surname: "Shevchenko",
                                              avatarLink: "https://images.pexels.com/photos/1933873/pexels-photo-1933873.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                                              rating: 3.4,
                                              offersCount: 192,
                                              email: "shevchenko@mail.ru",
                                              phoneNumber: "77479281192"),
                              overview: "Lorem ipsum bla bla bla",
                              busyDates: [],
                              facilities: [],
                              imageLinks: [],
                              location: CLLocation(latitude: 0, longitude: 0)))
        }
        
//        AF.request(URLs.getHouseFull, method: .get, parameters: parameters, headers: headers).validate().responseJSON { response in
//            switch response.result {
//            case .success(_):
//                let json = JSON(response.data!)
//
//                var busyDates: [Date] = []
//                var imageLinks: [String] = []
//                var facilities: [String] = []
//
//                for facility in json["facilities"].array ?? [] {
//                    facilities.append(facility["name"].stringValue)
//                }
//
//                for imageLink in json["image_links"].array ?? [] {
//                    imageLinks.append(imageLink.stringValue)
//                }
//
//                for busyDate in json["busy_dates"].array ?? [] {
//                    let date = Date(timeStamp: busyDate.stringValue)
//                    busyDates.append(date)
//                }
//
//                let location: CLLocation = CLLocation(latitude: json["latitude"].doubleValue,
//                                                      longitude: json["longitude"].doubleValue)
//
//                let landlord: Landlord = Landlord(id:           json["landlord"]["landlord_id"].stringValue,
//                                                  name:         json["landlord"]["name"].stringValue,
//                                                  surname:      json["landlord"]["surname"].stringValue,
//                                                  avatarLink:   json["landlord"]["avatar_link"].stringValue,
//                                                  rating:       json["landlord"]["rating"].doubleValue,
//                                                  offersCount:  json["landlord"]["offers_count"].intValue,
//                                                  email:        json["landlord"]["email"].stringValue,
//                                                  phoneNumber:  json["landlord"]["phone_number"].stringValue)
//
//                let houseFull: HouseFull = HouseFull(imageLink:     json["preview_link"].stringValue,
//                                                     id:            json["id"].stringValue,
//                                                     price:         String(json["price"].floatValue),
//                                                     reviews:       json["reviews"].stringValue,
//                                                     landlord:      landlord,
//                                                     overview:      json["overview"].stringValue,
//                                                     busyDates:     busyDates,
//                                                     facilities:    facilities,
//                                                     imageLinks:    imageLinks,
//                                                     location:      location)
//
//                handler(houseFull)
//            case .failure(let error):
//                Logger.log(.error, "Error: \(error)")
//            }
//        }
    }
}
