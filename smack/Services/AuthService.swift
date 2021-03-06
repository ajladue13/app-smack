//
//  AuthService.swift
//  smack
//
//  Created by Alex LaDue on 12/3/17.
//  Copyright © 2017 Alex LaDue. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthService {
    //singleton -- can be only one isntance in the app
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
 
    var authToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()

        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_REGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString {
            (response) in
            
            if response.result.error == nil {
                completion(true)
            } else{
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON{
            (response) in
            
            if response.result.error == nil {
                
                //Using swiftyJSON
//                guard let data = response.data else { return }
//                let json = JSON(data: data)
//                self.userEmail = json["user"].stringValue
//                self.authToken = json["token"].stringValue
                
//            Using regular Swift
            if let json = response.result.value as? Dictionary<String,Any> {
                if let email = json["user"] as? String {
                    self.userEmail = email
                }
                if let token = json["token"] as? String {
                    self.authToken = token
                 }
            }
                
                self.isLoggedIn = true
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler ) {
        
        
        var nameValue: String?
        var emailValue: String?
        var idValue: String?
        var colorValue: String?
        var avatarNameValue: String?
        
        
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        
        let header = [
            "Authorization": "Bearer \(AuthService.instance.authToken)",
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            if response.result.error == nil{
                
                if let json = response.result.value as? Dictionary<String,Any> {
                    if let id = json["_id"] as? String {
                        idValue = id
                    }
                    if let color = json["avatarColor"] as? String {
                        colorValue = color
                    }
                    if let avatarName = json["avatarName"] as? String {
                        avatarNameValue = avatarName
                    }
                    if let email = json["email"] as? String {
                        emailValue = email
                    }
                    if let name = json["name"] as? String {
                        nameValue = name
                    }
                    
                    
                }
                
                UserDataService.instance.setUserData(id: idValue!, color: colorValue!, avatarName: avatarNameValue!, email: emailValue!, name: nameValue!)
                completion(true)
            }else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
            
        }
        
    }
    
    
    
    
    
    
    
    
}
