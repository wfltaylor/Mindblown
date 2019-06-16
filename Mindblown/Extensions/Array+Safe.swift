//
//  Array+Safe.swift
//  Mindblown
//
//  Created by William Taylor on 15/6/19.
//  Copyright © 2019 William Taylor. All rights reserved.
//

import Foundation

extension Array {
    
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}
