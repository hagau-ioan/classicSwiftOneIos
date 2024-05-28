//
//  WriteValueBackDelegate.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 23.04.2024.
//

import UIKit

// "AnyObject" open the posibility to use "weak" attribute for object class references implementing this reference.
protocol WriteValueBackDelegate: AnyObject {
    associatedtype T
    func onWriteValueBack<T>(_ data: T)
}
