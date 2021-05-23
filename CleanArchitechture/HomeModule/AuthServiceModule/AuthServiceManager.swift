//
//  AuthServiceManager.swift
//  CleanArchitechture
//
//  Created by Subhra Roy on 20/05/21.
//

import Foundation

typealias HandleResult = (_ userModel: UserDataModel?) -> Void
protocol AuthServiceProtocol {
    func authenticate(handler: @escaping HandleResult) -> Void
}

struct UserJson {
    public let email: String
    public let userId: String
    public let authToken: String
}

struct AuthServiceAPI {
    func authService(model: AuthModel, handler: @escaping (_ statusCode: Int, _ userModel: UserDataModel?) -> Void) -> Void{
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now()) {
            let userJson = UserJson(email: model.email.value, userId: "123", authToken: "AVGFYDE42167HJJEFJESWDGCXHKWWLL")
            handler(200, self.getUser(json: userJson))
        }
    }
    
    private func getUser(json: UserJson) -> UserDataModel {
        return  UserDataModel(_email: json.email, _password: "", token: json.authToken, userid: json.userId)
    }
    
}
