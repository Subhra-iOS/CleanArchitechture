//
//  ListViewController+Services.swift
//  CleanArchitechture
//
//  Created by Subhra Roy on 24/05/21.
//

import Foundation

extension ListViewController {
    
    func fetchItemListWith(user: UserDataModel?) -> ItemServiceProtocol?{
        guard let userModel = user else { return  nil }
        let service = ListServiceAdapter(api: ListServiceAPI(), user: userModel)
        return service
    }
    
}
