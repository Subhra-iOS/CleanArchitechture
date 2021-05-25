//
//  ListTableViewCell.swift
//  CleanArchitechture
//
//  Created by Subhra Roy on 24/05/21.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet private weak var itemTitle: UILabel!
    @IBOutlet private weak var itemDescription: UILabel!
    
    var itemCellViewModel: ListCellViewModel! {
        didSet{
            self.itemTitle.text = itemCellViewModel.itemTitle
            self.itemDescription.text = itemCellViewModel.itemDescription
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
