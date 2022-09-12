//
//  CoreClass.swift
//  Core
//
//  Created by Maksim Sashcheka on 12.09.22.
//

import Foundation

public class CoreClass {
    var name: String
    
    public init(name: String) {
        self.name = name
    }
    
    public func printName() {
        print("Hello from Core module with name \(name)!")
    }
}
