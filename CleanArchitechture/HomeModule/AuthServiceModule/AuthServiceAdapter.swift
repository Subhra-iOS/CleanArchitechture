//
//  AuthServiceAdapter.swift
//  CleanArchitechture
//
//  Created by Subhra Roy on 22/05/21.
//

import Foundation

struct AuthServiceAdapter : AuthServiceProtocol {
    private var _user: AuthModel!
    private var api: AuthServiceAPI!
    init(authUser: AuthModel, api: AuthServiceAPI) {
        self._user = authUser
        self.api = api
    }
    func authenticate(handler: @escaping HandleResult) -> Void {
        self.api.authService(model: self._user) { (state, response) in
            handler(response)
        }
    }
}
