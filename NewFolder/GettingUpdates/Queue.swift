//
//  Queue.swift
//  GettingUpdates
//
//  Created by Lavanya Chebolu on 04/11/20.
//  Copyright © 2020 Lavanya Chebolu. All rights reserved.
//

import Foundation
protocol Queue {
    
    var count: Int {get}
    mutating func push(_ element: Int)
    mutating func pop() -> Int
}
