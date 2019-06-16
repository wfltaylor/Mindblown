//
//  Array+Appending.swift
//  Mindblown
//
//  Created by William Taylor on 15/6/19.
//  Copyright © 2019 William Taylor. All rights reserved.
//

import Foundation

extension Array {
    
    func appending(_ item: Element) -> [Element] {
        var newArray = self
        newArray.append(item)
        return newArray
    }
    
}
