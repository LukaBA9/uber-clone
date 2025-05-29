//
//  UCStack.swift
//  Uber Clone
//
//  Created by Luka on 24.5.25..
//

import Foundation

struct UCStack<T> {
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    
    mutating func pop() -> T {
        return items.removeLast()
    }
    
    mutating func peek() -> T? {
        return items.last
    }
    
    var count: Int { return items.count }
}
