//
//  GenericObserver.swift
//  CleanArchitechture
//
//  Created by Subhra Roy on 20/05/21.
//
//Property Observer Generic Class
import Foundation

final class GenericObserver<T>{
    typealias Listner = (T) -> Void
    private var eventListner: Listner?
    
    init(value: T) {
        self.value = value
    }
    
    var value: T {
        didSet{
            self.eventListner?(value)
        }
    }
    
    func bind(listner: Listner?){
        self.eventListner = listner
        listner?(self.value)
    }
}


