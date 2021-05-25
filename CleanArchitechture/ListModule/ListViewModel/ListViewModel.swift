//
//  ListViewModel.swift
//  CleanArchitechture
//
//  Created by Subhra Roy on 24/05/21.
//

// Response<[ListItemModel]?, Result>
import Foundation

typealias HandleItems = (_ list: [ListItemModel]?, _ error: Result) -> Void

protocol ItemServiceProtocol {
    func loadItems(results: HandleItems?) -> Void
}

protocol FetchItemOnSelectProtocol {
    func didSelect(item: ListItemModel) -> Void
}

struct ListViewModel {
    
    private var selectDelegate: FetchItemOnSelectProtocol?
    var listService: ([ListCellViewModel]?) -> Void
    
    init(delegate: FetchItemOnSelectProtocol? , list: @escaping ([ListCellViewModel]?) -> Void) {
        self.selectDelegate = delegate
        self.listService = list
    }
    
     func generateListView(models: [ListItemModel]?) -> Void{
        guard let list = models else {
            self.listService(nil)
            return
        }
        let items = list.map { (itemModel) -> ListCellViewModel in
            return ListCellViewModel(title: itemModel.itemTitle, description: itemModel.itemDescription, id: itemModel.itemId) { (model) in
                selectDelegate?.didSelect(item: model)
            }
        }
        self.listService(items)
    }
}
