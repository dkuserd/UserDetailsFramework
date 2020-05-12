//
//  FetchUserDetails.swift
//  UserDetailsFramework
//
//  Created by Dadha Kumar on 11/5/20.
//  Copyright © 2020 Dadha Kumar. All rights reserved.
//

import UIKit

public class UserInfo {
    
    public var fullName: String = ""
    public var gender: String = ""
    public var age: String = ""
    public var dob: String = ""
    public var email: String = ""
    public var userId: String = ""
    
    public init() {
        
    }
}

struct ServiceAPIKeys {
    static var gender = "https://randomuser.me/api/?gender="
    static var userId = "https://randomuser.me/api/?seed="
    static var mulUsers = "https://randomuser.me/api/?results="
}

public class FetchUserDetails: UIViewController {
    
    public static let sharedInstance = FetchUserDetails()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func formatDate(dateString: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "dd MMM yyyy"

        if let date = dateFormatterGet.date(from: dateString) {
            return(dateFormatterOutput.string(from: date))
        } else {
            let err = "error while decoding"
            return err
        }
    }
    
    public func executeUrlRequestMethod(gender: String? = "", userId: String? = "", completionHandler: @escaping(UserInfo?, Error?) -> Void) {
        var jsonUrlString: String = ""
        if let genderUn = gender, let userIdUn = userId, userIdUn.isEmpty {
            jsonUrlString = ServiceAPIKeys.gender + genderUn
        }
        if let userIdUn = userId, !userIdUn.isEmpty {
            jsonUrlString = ServiceAPIKeys.userId + userIdUn
        }
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        var fullName: String = ""
        var gender: String = ""
        var age: String = ""
        var dob: String = ""
        var email: String = ""
        var userId: String = ""
        /// To pass in completionHandler
        let userInfo = UserInfo()
        
        URLSession.shared.dataTask(with: request) { (data, url, error) in
            
            guard let data = data else {
                return }
            do {
                
                let jsonDecoder = try JSONDecoder().decode(UserDetailsResponse.self, from: data)
                if let results = jsonDecoder.results, let info = jsonDecoder.info {
                    for json in results {
                        if let fName = json.name?.first, let lName = json.name?.last {
                            fullName = fName + " " + lName
                        }
                        if let genderUnWrapped = json.gender {
                            gender = genderUnWrapped
                        }
                        if let dobUnwrapped = json.dob?.date {
                            dob = self.formatDate(dateString: dobUnwrapped)
                        }
                        if let ageUnwrapped = json.dob?.age {
                            age = String(describing: ageUnwrapped)
                        }
                        if let emailUnwrapped = json.email {
                            email = emailUnwrapped
                        }
                        if let userIdUnwrapped = info.seed {
                            userId = userIdUnwrapped
                        }
                        
                        userInfo.fullName = fullName
                        userInfo.gender = gender
                        userInfo.dob = dob
                        userInfo.age = age
                        userInfo.email = email
                        userInfo.userId = userId
                        
                    }
                    
                    completionHandler(userInfo, nil)
                }
                
            } catch let jsonDecoderError {
                
                print("error while decoding: ", jsonDecoderError)
                completionHandler(nil, jsonDecoderError)
            }
            
        }.resume()
        
    }
    
    public func executeUrlRequestMulUsers(mulUsers: String? = "", completionHandler: @escaping([UserInfo]?, Error?) -> Void) {
        var jsonUrlString: String = ""
        if let mulUsersUn = mulUsers {
            jsonUrlString = ServiceAPIKeys.mulUsers + mulUsersUn
        }
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        var userInfoMulUsers: [UserInfo] = [UserInfo]()
        var fullName: String = ""
        var gender: String = ""
        var age: String = ""
        var dob: String = ""
        var email: String = ""
        var userId: String = ""
        
        URLSession.shared.dataTask(with: request) { (data, url, error) in
            
            guard let data = data else {
                return }
            do {
                
                let jsonDecoder = try JSONDecoder().decode(UserDetailsResponse.self, from: data)
                if let results = jsonDecoder.results, let info = jsonDecoder.info {
                    for json in results {
                        let userInfo = UserInfo()
                        if let fName = json.name?.first, let lName = json.name?.last {
                            fullName = fName + " " + lName
                        }
                        if let genderUnWrapped = json.gender {
                            gender = genderUnWrapped
                        }
                        if let dobUnwrapped = json.dob?.date {
                            dob = self.formatDate(dateString: dobUnwrapped)
                        }
                        if let ageUnwrapped = json.dob?.age {
                            age = String(describing: ageUnwrapped)
                        }
                        if let emailUnwrapped = json.email {
                            email = emailUnwrapped
                        }
                        if let userIdUnwrapped = info.seed {
                            userId = userIdUnwrapped
                        }
                        userInfo.fullName = fullName
                        userInfo.gender = gender
                        userInfo.dob = dob
                        userInfo.age = age
                        userInfo.email = email
                        userInfo.userId = userId
                        userInfoMulUsers.append(userInfo)
                    }
                    
                    completionHandler(userInfoMulUsers, nil)
                }
                
            } catch let jsonDecoderError {
                
                print("error while decoding: ", jsonDecoderError)
                completionHandler(nil, jsonDecoderError)
            }
            
        }.resume()
        
    }
    
    
}
