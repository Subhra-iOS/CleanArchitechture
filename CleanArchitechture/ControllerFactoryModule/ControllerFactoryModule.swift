//
//  ControllerFactoryModule.swift
//  CleanArchitechture
//
//  Created by Subhra Roy on 28/05/21.
//

import Foundation
import UIKit

struct ControllerFactory {
    
    var factoryDelegate: FactoryProtocol?
    
    func creatRootViewController(_ model: AuthModel , _ storyBoard: UIStoryboard) -> ViewController{
        let _viewController : ViewController = storyBoard.instantiateViewController(identifier: "RootViewControllerIdentifier", creator: { (coder) -> ViewController? in
            return ViewController(coder: coder, viewModel: HomeViewModel(authModel: model, success: {  user in
                user.authenticationSucceed() ? factoryDelegate?.didUpdate(user) : nil
            }))
        })
        return _viewController
    }
    
    func creatListViewController(_ user: UserDataModel, _ storyBoard: UIStoryboard) -> ListViewController {
        let _listVC : ListViewController = storyBoard.instantiateViewController(identifier: "ListViewControllerIdentifier", creator: { (coder) -> ListViewController? in
            return ListViewController(coder: coder, user: user)
        })
        return _listVC
    }
    
}
