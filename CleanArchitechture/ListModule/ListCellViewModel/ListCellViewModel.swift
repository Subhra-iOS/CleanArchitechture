//
//  ListCellViewModel.swift
//  CleanArchitechture
//
//  Created by Subhra Roy on 24/05/21.
//

import Foundation

struct ListCellViewModel {
    let itemTitle: String?
    let itemDescription: String?
    let itemId: String?
    var select: (ListItemModel) -> Void
    
    init(title: String?, description: String?, id: String?, closure: @escaping ((ListItemModel) -> Void)) {
        self.itemTitle = title
        self.itemDescription = description
        self.itemId = id
        self.select = closure
    }
    
}
