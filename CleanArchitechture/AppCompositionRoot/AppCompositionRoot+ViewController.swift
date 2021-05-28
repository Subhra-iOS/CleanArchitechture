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
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
}

