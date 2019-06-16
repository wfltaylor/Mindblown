//
//  PreferenceSheetView.swift
//  Mindblown
//
//  Created by William Taylor on 14/6/19.
//  Copyright © 2019 William Taylor. All rights reserved.
//

import Cocoa
import AVKit

//MARK: - PreferencesSheetController
class PreferenceSheetController: NSWindowController, NSWindowDelegate, NSTableViewDataSource, NSTableViewDelegate {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var tableView: NSTableView!
    
    @IBOutlet weak var modeSegmentedControl: NSSegmentedControl!
    
    @IBOutlet weak var playerView: AVPlayerView!
    
    @IBOutlet weak var versionNumberLabel: NSTextField!
    
    //MARK: Properties
    
    var animationType = AnimationType.threeD
    
    //MARK: Lifecylcle
    
    override func windowDidLoad() {
        super.windowDidLoad()
        setup()
    }
    
    //MARK: Setup
    
    func setup() {
        setupAnimationType()
        setupTableView()
        setupPlayerView()
        setupVersionNumberLabel()
    }
    
    func setupAnimationType() {
        guard let mode = Defaults.animations.first?.animationType else { return }
        animationType = mode
        
        switch animationType {
        case .threeD:
            modeSegmentedControl.selectedSegment = 1
        case .twoD:
            modeSegmentedControl.selectedSegment = 0
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupPlayerView() {
        playerView.controlsStyle = .minimal
       
        if let fileName = animationsFor(type: animationType).first?.fileName {
             playVideo(with: fileName)
        }
    }
    
    func setupVersionNumberLabel() {
        if let screensaverVersion = Bundle(for: PreferenceSheetController.self).infoDictionary?["CFBundleShortVersionString"] as? String {
            versionNumberLabel.stringValue = "V\(screensaverVersion)"
        }
    }
    
    //MARK: UI Actions
    
    @IBAction func modeSegmentedControlAction(_ sender: Any) {
        animationType = modeSegmentedControl.selectedSegment == 0 ? .twoD : .threeD
        Defaults.set(animations: animationsFor(type: animationType))
        
        tableView.reloadData()
        
        if let fileName = animationsFor(type: animationType).first?.fileName {
            playVideo(with: fileName)
        }
    }
    
    @IBAction func doneAction(_ sender: Any) {
        guard let window = window else { return }
        window.sheetParent?.endSheet(window)
        window.close()
    }
    
    //MARK: NSTableViewDataSource
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return animationsFor(type: animationType).count
    }
    
    //MARK: NSTableViewDelegate
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let animation = animationsFor(type: animationType)[row]
        
        let identifier = NSUserInterfaceItemIdentifier(rawValue: "CheckboxCell")
        guard let cell = tableView.makeView(withIdentifier: identifier, owner: owner) as? CheckboxTableViewCell else { fatalError("Failed to deque cell") }
        
        cell.name = animation.displayName
        cell.checked = Defaults.animations.contains { $0 == animation }
        cell.checkedStateChanged = {
            if cell.checked {
                if !Defaults.animations.contains { $0 == animation } {
                    Defaults.set(animations: Defaults.animations.appending(animation))
                }
            } else {
                if Defaults.animations.contains(where: { $0 == animation }) {
                    Defaults.set(animations: Defaults.animations.removingAll { $0 == animation })
                }
            }
        }
        
        return cell
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        guard let selectedAnimation = animationsFor(type: animationType)[safe: tableView.selectedRow] else { return }
        
        playVideo(with: selectedAnimation.fileName)
    }
    
    //MARK: Helper Methods
    
    func animationsFor(type: AnimationType) -> [Animation] {
        return Animations.all.filter { $0.animationType == type }
    }
    
    func url(for item: String) -> URL? {
        return Bundle(for: PreferenceSheetController.self).url(forResource: item, withExtension: nil)
    }
    
    func playVideo(with fileName: String) {
        if let videoURL = url(for: fileName) {
            playerView.player = AVPlayer(url: videoURL)
            playerView.player?.play()
        }
    }
    
}
