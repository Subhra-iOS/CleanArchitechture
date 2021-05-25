//
//  UIViewController+Utility.swift
//  CleanArchitechture
//
//  Created by Subhra Roy on 20/05/21.
//

import Foundation
import UIKit

extension  UIViewController{
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
