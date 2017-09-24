//
//  PlayerViewController.swift
//  SwiftPlayer
//
//  Created by Omer Mohamed Ali on 24/09/2017.
//  Copyright © 2017 Omer Mohamed Ali. All rights reserved.
//

import Cocoa

class PlayerViewController: NSViewController {
    @IBOutlet weak var playButton: NSButton!
    @IBOutlet weak var rewindButton: NSButton!
    @IBOutlet weak var nextButton: NSButton!
    @IBOutlet weak var volumeSlider: NSSlider!

    @IBOutlet weak var timeLabel: NSTextField!
    @IBOutlet weak var shuffleButton: NSButton!
    @IBOutlet weak var replayButton: NSButton!
    
    let manager = PlayerManager.sharedManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let nc = NotificationCenter.default
        nc.addObserver(
            self,
            selector: #selector(startPlaying),
            name: Notification.Name(Constants.Notifications.StartPlaying),
            object: nil
        )
    }
    
    @IBAction func play(_ sender: NSButton) {
        manager.play()
        
        if manager.isPlaying {
            playButton.image =  NSImage(named: "Pause")
        } else {
            playButton.image = NSImage(named: "Play")
        }
    }
    
    @IBAction func rewind(_ sender: NSButton) {
        manager.rewind()
    }
    
    @IBAction func next(_ sender: NSButton) {
        manager.next()
    }
    
    @IBAction func shuffle(_ sender: NSButton) {
        manager.isShuffle = !manager.isShuffle
    }
    
    @IBAction func repeatPlaylist(_ sender: NSButton) {
        manager.isRepeated = !manager.isRepeated
    }
    
    // MARK: - Helpers
    
    func startPlaying(notification: Notification) {
        print("received", notification)
        
        guard let song = notification.userInfo?[Constants.NotificationUserInfos.Song] as? Song else { return }
        timeLabel.stringValue = "0:00"
    }
}
