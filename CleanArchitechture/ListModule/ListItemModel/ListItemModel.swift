//
//  ListItemModel.swift
//  CleanArchitechture
//
//  Created by Subhra Roy on 24/05/21.
//

import Foundation

struct ListItemModel: Equatable {
    let itemTitle: String?
    let itemDescription: String?
    let itemId: String?
    
    static func == (lhs: Self, rhs: Self) -> Bool{
        return (lhs.itemTitle == rhs.itemTitle
                && lhs.itemId == rhs.itemId
                && lhs.itemDescription == rhs.itemDescription)
    }
}

