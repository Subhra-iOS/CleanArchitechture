//
//  ListViewController.swift
//  CleanArchitechture
//
//  Created by Subhra Roy on 20/05/21.
//

import Foundation
import UIKit

class ListViewController: UIViewController{
    
    @IBOutlet weak var listTableView: UITableView!
    private var userModel : UserDataModel?
    
    init?(coder: NSCoder, user: UserDataModel?) {
        self.userModel = user
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("You must create this view controller with a user.")
    }
}
