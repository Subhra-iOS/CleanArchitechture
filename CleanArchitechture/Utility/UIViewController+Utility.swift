//
//  UIViewController+Utility.swift
//  CleanArchitechture
//
//  Created by Subhra Roy on 20/05/21.
//

import Foundation
import UIKit

//MARK:-------------Navigation of any viewcontroller----------//
extension ViewController{
    
    public func moveToControllerWith(userModel: UserDataModel?){
        
        guard let listVC : ListViewController = storyboard?.instantiateViewController(identifier: "ListViewControllerIdentifier", creator: { coder in
            return ListViewController(coder: coder, user: userModel)
        }) else {
            fatalError("Failed to load ListViewController from storyboard.")
        }
        showDetailViewController(listVC, sender: self)
    }
    
    public func getCurrentWorkingThread(work: @escaping () -> Void) -> Void{
        if Thread.isMainThread{
            work()
        }else{
            DispatchQueue.main.async {
                work()
            }
        }
    }
}
