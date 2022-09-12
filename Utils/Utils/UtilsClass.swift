//
//  UtilsClass.swift
//  Utils
//
//  Created by Maksim Sashcheka on 12.09.22.
//

import Foundation

public class UtilsClass {
    var name: String
    
    public init(name: String) {
        self.name = name
    }
    
    public func printName() {
        print("Hello from Utils module with name \(name)!")
    }
}
