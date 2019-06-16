//
//  Animation.swift
//  Mindblown
//
//  Created by William Taylor on 15/6/19.
//  Copyright © 2019 William Taylor. All rights reserved.
//

import Foundation

//MARK: - Animation
struct Animation: Equatable {
    
    var fileName: String
    
    var displayName: String
    
    var animationType: AnimationType
    
}

//MARK: - Animation Type
enum AnimationType {
    case twoD
    case threeD
}

//MARK: - Animations
struct Animations {
    
    //MARK: Sets
    
    static let all = [chicken3D, bear3D, alien3D, robot3D, robot2D, alien2D, skull2D, monkey2D]
    
    static let defaultSet = [chicken3D, bear3D, alien3D, robot3D]
    
    //MARK: 3D Animations
    
    static let robot3D = Animation(fileName: "robot_3D.mp4", displayName: "Robot", animationType: .threeD)
    
    static let chicken3D = Animation(fileName: "chicken_3D.mp4", displayName: "Chicken", animationType: .threeD)
    
    static let alien3D = Animation(fileName: "alien_3D.mp4", displayName: "Alien", animationType: .threeD)
    
    static let bear3D = Animation(fileName: "monkey_3D.mp4", displayName: "Monkey", animationType: .threeD)
    
    //MARK: 2D Animations
    
    static let robot2D = Animation(fileName: "robot_2D.mp4", displayName: "Robot", animationType: .twoD)
    
    static let alien2D = Animation(fileName: "alien_2D.mp4", displayName: "Alien", animationType: .twoD)
    
    static let skull2D = Animation(fileName: "skull_2D.mp4", displayName: "Skull", animationType: .twoD)
    
    static let monkey2D = Animation(fileName: "monkey_2D.mp4", displayName: "Monkey", animationType: .twoD)
    
    //MARK: Methods
    
    static func animation(fromFilename filename: String) -> Animation? {
        switch filename {
        case robot3D.fileName: return robot3D
        case chicken3D.fileName: return chicken3D
        case alien3D.fileName: return alien3D
        case bear3D.fileName: return bear3D
        case alien2D.fileName: return alien2D
        case robot2D.fileName: return robot2D
        case skull2D.fileName: return skull2D
        case monkey2D.fileName: return monkey2D
        default: return nil
        }
    }
    
    //MARK: Hide Initilizer
    
    private init() { }
    
}

