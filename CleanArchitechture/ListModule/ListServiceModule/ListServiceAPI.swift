//
//  ListServiceAPI.swift
//  CleanArchitechture
//
//  Created by Subhra Roy on 24/05/21.
//

import Foundation

struct ListServiceAPI {
    func loadListService(model: UserDataModel, handler: @escaping (_ statusCode: Int, _ list: [ListItemModel]?) -> Void) -> Void{
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now()) {
            let _items = self.getList()
            handler(200, _items)
        }
    }
    
    private func getList() -> [ListItemModel] {
        return  [ListItemModel(itemTitle: "item1", itemDescription: "This is the new item1", itemId: "100"),
                 ListItemModel(itemTitle: "item2", itemDescription: "This is the new item2", itemId: "101"),
                 ListItemModel(itemTitle: "item3", itemDescription: "This is the new item3", itemId: "102"),
                 ListItemModel(itemTitle: "item4", itemDescription: "This is the new item4", itemId: "103"),
                 ListItemModel(itemTitle: "item5", itemDescription: "This is the new item5", itemId: "104")]
    }
    
}
