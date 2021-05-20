//
//  UserDataModel.swift
//  CleanArchitechture
//
//  Created by Subhra Roy on 20/05/21.
//

import Foundation

struct UserDataModel {
    public var email: String!
    public var password: String!
    public var userToken: String?
    public var userID: String?
    
    init(_email: String, _password: String, token: String? = nil, userid: String? = nil) {
        self.email = _email
        self.password = _password
        self.userToken = token
        self.userID = userid
    }
    
    mutating func update(user: UserDataModel?){
        self.email = user?.email
        self.password = user?.password
        self.userToken = user?.userToken
        self.userID = user?.userID
    }
    
    func isValidUserEntry() -> Bool{
        return self.email.count > 0 && self.password.count > 0
    }
    
    func authenticationSucceed() -> Bool {
        guard let userId = self.userID, let token = self.userToken else { return false }
        return userId.count > 0 && token.count > 0
    }
}
