//
//  SceneDelegate+Navigation.swift
//  CleanArchitechture
//
//  Created by Subhra Roy on 28/05/21.
//

import Foundation
import  UIKit

extension SceneDelegate: FactoryProtocol {
    
    func didUpdate(_ user: UserDataModel?){
        guard let model = user else { return }
        let _storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let _listVC = controllerFactory.creatListViewController(model, _storyboard)
        self.compositionRoot.navigation.pushViewController(_listVC, animated: true)
    }
    
    func initiateRoot() -> AppCompositionRoot{
        let _storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let userAuth: AuthModel = AuthModel(email: "", pwd: "")
        let rootVC: ViewController = controllerFactory.creatRootViewController(userAuth, _storyboard)
        let navigationController: UINavigationController = UINavigationController(rootViewController: rootVC)
        return  AppCompositionRoot(navigation: navigationController, appWindow: self.window)
    }
    
    
}
