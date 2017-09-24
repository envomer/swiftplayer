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
    @IBOutlet weak var songTitleLabel: NSTextField!
    
    var songTimer: Timer?
    var songProgress: Double = 0
    
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
        
        nc.addObserver(
            self,
            selector: #selector(pausePlaying),
            name: Notification.Name(Constants.Notifications.PausePlaying),
            object: nil
        )
        
        nc.addObserver(
            self,
            selector: #selector(changeSong),
            name: Notification.Name(Constants.Notifications.ChangeSong),
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
        songTimer = Timer.scheduledTimer(
            timeInterval: TimeInterval(1),
            target: self,
            selector: #selector(updateProgress),
            userInfo: nil,
            repeats: true
        )
    }
    
    func pausePlaying(notification: Notification) {
        songTimer?.invalidate()
        songTimer = nil
    }
    
    func changeSong(notification: Notification) {
        timeLabel.stringValue = "0:00"
        
        songProgress = 0
        songTimer?.invalidate()
        songTimer = nil
        
        guard let song = notification.userInfo?[Constants.NotificationUserInfos.Song] as? Song else { return }
        
        songTitleLabel.stringValue = song.title
    }
    
    // MARK: - Timer
    func updateProgress() {
        songProgress += 1
        let formatter = DateComponentsFormatter()
        
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad
        timeLabel.stringValue = "\(formatter.string(from: songProgress)!)"
    }
}
