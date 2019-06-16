//
//  AppDelegate.swift
//  Mindblown Preferences Host
//
//  Created by William Taylor on 14/6/19.
//  Copyright © 2019 William Taylor. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    let preferencesView = PreferenceSheetController(windowNibName:  "PreferenceSheetController")
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        window.close()
        preferencesView.window?.makeKeyAndOrderFront(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

struct Config {
    static let runningMode = RunningMode.testHost
}
