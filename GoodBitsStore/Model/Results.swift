//
//  File.swift
//  
//
//  Created by Manu Puthoor on 12/03/20.
//

import Foundation

enum Results<T> {
    case success(T)
    case failure(errorStr: String, model:T? = nil)
}
