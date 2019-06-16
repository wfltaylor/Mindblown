//
//  CheckboxTableViewCell.swift
//  Mindblown
//
//  Created by William Taylor on 15/6/19.
//  Copyright © 2019 William Taylor. All rights reserved.
//

import Cocoa

//MARK: - CheckboxTableViewCell
class CheckboxTableViewCell: NSTableCellView {
    
    //MARK: IBOutlets
    
    @IBOutlet private weak var button: NSButton!
    
    //MARK: Properties
    
    var name: String {
        get {
            return button.title
        }
        set {
            button.title = newValue
        }
    }
    
    var checked: Bool {
        get {
            return button.state == .on
        }
        set {
            button.state = newValue ? .on : .off
        }
    }
    
    var checkedStateChanged: (() -> Void)? = nil
    
    //MARK: UI Actions
    
    @IBAction private func buttonAction(_ sender: Any) {
        checkedStateChanged?()
    }
}
