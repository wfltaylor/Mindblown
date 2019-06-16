//
//  Defaults.swift
//  Mindblown
//
//  Created by William Taylor on 15/6/19.
//  Copyright © 2019 William Taylor. All rights reserved.
//

import Foundation
import ScreenSaver
import os

//MARK: - Defaults
struct Defaults {
    
    //MARK: Key
    struct Key {
        static let animations = "animations"
    }
    
    //MARK: Properties
    
    private static var screensaverDefaults: UserDefaults {
        get {
            guard let defaults = userDefaults() else { fatalError("Unable to initialize defaults") }
            defaults.register(defaults: [Key.animations: Animations.defaultSet.map { $0.fileName }])
            return defaults
        }
    }
    
    //MARK: Methods
    
    static var animations: [Animation] {
        get {
            guard let animationFileNames = screensaverDefaults.array(forKey: Key.animations) as? [String] else { return Animations.defaultSet }
            let animations = animationFileNames.compactMap { return Animations.animation(fromFilename: $0) }
            return animations
        }
    }
    
    static func set(animations: [Animation]) {
        screensaverDefaults.set(animations.map { $0.fileName }, forKey: Key.animations)
        screensaverDefaults.synchronize()
    }
    
    //MARK: Helper Functions
    
    private static func userDefaults() -> UserDefaults? {
        switch Config.runningMode {
        case .screensaver:
            return ScreenSaverDefaults(forModuleWithName: "com.williamtaylor.mindblown")
        case .testHost:
            return UserDefaults(suiteName: "mindblownscreensaver.testprefs")
        }
    }
    
}

enum RunningMode {
    case screensaver
    case testHost
}
