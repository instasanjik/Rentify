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

class Server {
    
    static let sharedInstance = Server()
    
    var currencyMultiplyer: Double = 1
    
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
        let parameters = [
            "access_token" : Server.sharedInstance.accessToken
        ]
        
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
        //
        let headers: HTTPHeaders = [
            "apikey": "IeyAgQ3DWic1Xfw0yaYHHvgPTqSDnKIO"
        ]
        AF.request(url, method: .get, headers: headers).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(response.data!)
                print(json)
                let convertedAmount = json["result"].doubleValue
                completion(.success(Double(Int(convertedAmount)/100*100)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
