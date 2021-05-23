//
//  ViewController+Services.swift
//  CleanArchitechture
//
//  Created by Subhra Roy on 22/05/21.
//

import Foundation
import UIKit

extension  ViewController {
    
    func triggerAuthService(user: UserDataModel) -> AuthServiceProtocol?{
        
        guard let userAuthModel: AuthModel = self.homeViewModel?.updateAuth(user: user) else {
            return nil
        }
        guard userAuthModel.isValid(email: user.email), userAuthModel.isValid(password: user.password) else{
            return nil
        }
        let adapter = AuthServiceAdapter(authUser: userAuthModel, api: AuthServiceAPI())
        return adapter
    }
}
