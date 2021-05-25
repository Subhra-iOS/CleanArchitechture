//
//  ListViewController+TableViewDelegate.swift
//  CleanArchitechture
//
//  Created by Subhra Roy on 24/05/21.
//

import Foundation
import UIKit

extension ListViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell : ListTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
            as? ListTableViewCell {
            if let itemArray = self.itemList , itemArray.count > 0 {
                let cellViewModel: ListCellViewModel = itemArray[indexPath.row]
                cell.itemCellViewModel = cellViewModel
            }
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let itemArray = self.itemList , itemArray.count > 0 {
            return itemArray.count
        }else{ return 0 }
    }
    
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let itemArray = self.itemList , itemArray.count > 0 {
            let cellViewModel: ListCellViewModel = itemArray[indexPath.row]
            cellViewModel.select(ListItemModel(itemTitle: cellViewModel.itemTitle, itemDescription: cellViewModel.itemDescription, itemId: cellViewModel.itemId))
        }
    }
    
}
