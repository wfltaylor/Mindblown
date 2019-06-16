//
//  Array+RemovingAll.swift
//  Mindblown
//
//  Created by William Taylor on 15/6/19.
//  Copyright © 2019 William Taylor. All rights reserved.
//

import Foundation

extension Array {
    
    func removingAll(where method: (Element) throws -> Bool) -> [Element] {
        var newArray = self
        try? newArray.removeAll(where: method)
        return newArray
    }
    
}
