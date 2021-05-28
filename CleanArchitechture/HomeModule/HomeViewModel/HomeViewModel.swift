//
//  HomeViewModel.swift
//  CleanArchitechture
//
//  Created by Subhra Roy on 20/05/21.
//

import Foundation

final class AuthModel {
    var email: GenericObserver<String> = GenericObserver<String>(value: "")
    var password: GenericObserver<String> = GenericObserver<String>(value: "")
    init(email: String, pwd: String) {
        self.email.value = email
        self.password.value = pwd
    }
    
    func isValid(email: String) -> Bool{
        guard email.count > 0 else { return false }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        var valid = NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
        if valid {
            valid = !email.contains("..")
        }
        return valid
    }
    
    func isValid(password: String) -> Bool{
        return password.count >= 6
    }
    
    func getUserEmail(_ closure: @escaping ((_ email: String) -> Void)){
        self.email.bind { [weak self] (_email) in
            guard let weakSelf = self else{
                closure("")
                return
            }
            weakSelf.isValid(email: _email) ? closure(_email) : closure("")
        }
    }
    
    func getUserPassword(_ closure: @escaping ((_ password: String) -> Void)){
        self.password.bind { [weak self] (_password) in
            guard let weakSelf = self else{
                closure("")
                return
            }
            weakSelf.isValid(password: _password) ? closure(_password) : closure("")
        }
    }
    
}

final class HomeViewModel {
    
    public var userAuth: AuthModel!
    public var authSuccess : (UserDataModel) -> Void
    
    init(authModel: AuthModel, success: @escaping ((UserDataModel) -> Void)) {
        self.userAuth = authModel
        self.authSuccess = success
    }
    
    func updateAuth(user: UserDataModel) -> AuthModel?{
        guard user.isValidUserEntry() else {
            return nil
        }
        self.userAuth.email.value = user.email
        self.userAuth.password.value = user.password
        return self.userAuth
    }
    
}
