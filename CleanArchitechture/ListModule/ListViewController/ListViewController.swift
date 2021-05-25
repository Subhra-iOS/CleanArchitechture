//
//  ListViewController.swift
//  CleanArchitechture
//
//  Created by Subhra Roy on 20/05/21.
//

import Foundation
import UIKit

let cellIdentifier = "itemCellIdentifier"

class ListViewController: UIViewController{
    
    @IBOutlet weak var listTableView: UITableView!
    private(set) var userModel : UserDataModel?
    private(set) var itemList: [ListCellViewModel]?
    private(set) var listViewModel: ListViewModel!
    
    var listService: ItemServiceProtocol?
    
    init?(coder: NSCoder, user: UserDataModel?) {
        self.userModel = user
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a user.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(String(describing: self.userModel?.email))")
        print("\(String(describing: self.userModel?.userToken))")
        print("\(String(describing: self.userModel?.userID))")
        self.listViewModel = ListViewModel( delegate: self, list: { [weak self] (cellViewModels) in
            guard let array = cellViewModels else {
                return
            }
            self?.itemList = array
            self?.getCurrentWorkingThread{ 
                self?.listTableView.reloadData()
            }
        })
        self.listTableView.register(UINib(nibName: "ListTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: cellIdentifier)
       
    }
    
    override  func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadRemoteDataList()
    }
    
    private func loadRemoteDataList(){
        self.listService = self.fetchItemListWith(user: self.userModel)
        guard let service = self.listService else { return }
        service.loadItems(results: handleResults)
    }
    
    private func handleResults(_ list: [ListItemModel]?, _ error: Result) -> Void{
        switch error {
            case .success:
                self.listViewModel.generateListView(models: list)
            case .failure(let message):
                print("Error message: \(message)")
        }
    }
}

extension ListViewController: FetchItemOnSelectProtocol {
    func didSelect(item: ListItemModel) {
        print("Selected item name : \(String(describing: item.itemTitle)) ; item des : \(String(describing: item.itemDescription)) ; item id : \(String(describing: item.itemId))")
    }

}
