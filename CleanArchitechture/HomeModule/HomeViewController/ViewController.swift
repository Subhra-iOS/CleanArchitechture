//
//  ViewController.swift
//  CleanArchitechture
//
//  Created by Subhra Roy on 20/05/21.
//

import UIKit

class ViewController: UIViewController {
    
    private var homeViewModel: HomeViewModel?
    private var userDataModel: UserDataModel = UserDataModel(_email: "", _password: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let userAuth: AuthModel = AuthModel(email: "", pwd: "")
        self.homeViewModel = HomeViewModel(authModel: userAuth, success: { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.userDataModel.authenticationSucceed() ? weakSelf.moveToControllerWith(userModel: weakSelf.userDataModel) : nil
        })
        
        self.homeViewModel?.userAuth?.getUserEmail({ (email) in
            self.userDataModel.email = email
        })
        
        self.homeViewModel?.userAuth?.getUserPassword({ (password) in
            self.userDataModel.password = password
        })
    }

    @IBAction func redirectToList(_ sender: Any) {
        let userAuth: UserDataModel = UserDataModel(_email: "subhra.roy@e-arc.com", _password: "123456")
        self.homeViewModel?.serverAuthenticationWith(user: userAuth, completion: { [weak self] (userModel) in
            self?.userDataModel.update(user: userModel)
            self?.getCurrentWorkingThread{
                self?.homeViewModel?.authSuccess()
            }
        })
    }
    
}


