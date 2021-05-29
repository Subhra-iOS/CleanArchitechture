//
//  AppCompositionRoot+ViewController.swift
//  CleanArchitechture
//
//  Created by Subhra Roy on 28/05/21.
//

import Foundation
import UIKit

protocol ListNavigationProtocol {
    func didNavigateToListWith(user: UserDataModel) -> Void
}

protocol FactoryProtocol {
    func didUpdate(_ user: UserDataModel?)
}

public struct AppCompositionRoot{
   
    var navigation: UINavigationController!
    private var appWindow: UIWindow?
    
    init(navigation: UINavigationController, appWindow: UIWindow?) {
        self.navigation = navigation
        self.appWindow = appWindow
        self.appWindow?.rootViewController = navigation
        self.appWindow?.makeKeyAndVisible()
    }
    
}

