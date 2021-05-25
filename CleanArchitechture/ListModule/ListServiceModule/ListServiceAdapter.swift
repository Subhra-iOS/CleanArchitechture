//
//  ListServiceAdapter.swift
//  CleanArchitechture
//
//  Created by Subhra Roy on 24/05/21.
//

import Foundation

struct ListServiceAdapter: ItemServiceProtocol {
   
    let api : ListServiceAPI
    let user: UserDataModel
    
    init(api: ListServiceAPI, user: UserDataModel) {
        self.api = api
        self.user = user
    }
    
    func loadItems(results: HandleItems?) -> Void {
        api.loadListService(model: self.user) { (statusCode, items) in
            switch  statusCode {
                case 200:
                    if let list : [ListItemModel] = items {
                        results?(list, Result.success)
                    }
                default:
                    results?(nil, Result.failure("Fail due to server error"))
            }
        }
    }
    
}

/*struct ListServiceFallbackAdapter: ItemServiceProtocol {
    let api : ItemServiceProtocol
    let cache: ItemServiceProtocol
    var shouldRetry: Bool = false
    var result: HandleItems
    
    init(api: ItemServiceProtocol, cache: ItemServiceProtocol, shouldRetry: Bool, closure: @escaping HandleItems) {
        self.api = api
        self.cache = cache
        self.shouldRetry = shouldRetry
        self.result = closure
    }
    
    func loadItems(results: HandleItems?) -> Void{
        
        //self ? self.fallback(self.api, self.result) : self.fallback(self.cache, self.result)
    }
    
}

extension ItemServiceProtocol {
    
    func fallback(_ service: ItemServiceProtocol , _ closure: @escaping HandleItems) -> Void{
        self.loadItems(results: closure)
    }
    
    //    func retry(_ count : UInt = 1){
    //        count == 0 ? self : self.
    //    }
    
}*/
