//
//  AuthServiceManager.swift
//  CleanArchitechture
//
//  Created by Subhra Roy on 20/05/21.
//

import Foundation

protocol AuthServiceProtocol {
    func authenticate(user: AuthModel, handler: @escaping (_ statusCode: Int, _ userJSONModel: UserJson) -> Void) -> Void
}

extension  AuthServiceProtocol {
    func authenticate(user: AuthModel, handler: @escaping (_ statusCode: Int, _ userJSONModel: UserJson) -> Void) -> Void {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now()) {
            handler(200, UserJson(email: user.email.value, userId: "123", authToken: "AVGFYDE42167HJJEFJESWDGCXHKWWLL"))
        }
    }
}

struct UserJson {
    public let email: String
    public let userId: String
    public let authToken: String
}
