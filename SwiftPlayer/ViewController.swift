//
//  ViewController.swift
//  SwiftPlayer
//
//  Created by Omer Mohamed Ali on 24/09/2017.
//  Copyright © 2017 Omer Mohamed Ali. All rights reserved.
//

import Cocoa
import MediaKeyTap

class ViewController: NSViewController {
    
    var mediaKeyTap: MediaKeyTap?
//    var manager: PlayerManager?
    
    func applicationDidFinishLaunching(aNotification: Notification) {
        mediaKeyTap = MediaKeyTap(delegate: self)
        mediaKeyTap?.start()
        print("laofoaf")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("loaded")
        
        mediaKeyTap = MediaKeyTap(delegate: self, on: .keyDownAndUp)
        mediaKeyTap?.start()
        
//        manager = PlayerManager.sharedManager

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

extension ViewController: MediaKeyTapDelegate {
    func handle(mediaKey: MediaKey, event: KeyEvent) {
        switch mediaKey {
        case .playPause:
            print("Play/pause pressed")
//            manager?.play()
//            toggleLabel(playPauseLabel, enabled: event.keyPressed)
        case .previous:
            print("Previous pressed")
//            manager?.rewind()
//            toggleLabel(previousLabel, enabled: event.keyPressed)
        case .rewind:
            print("Rewind pressed")
//            manager?.rewind()
//            toggleLabel(rewindLabel, enabled: event.keyPressed)
        case .next:
            print("Next pressed")
//            manager?.next()
//            toggleLabel(nextLabel, enabled: event.keyPressed)
        case .fastForward:
            print("Fast Forward pressed")
//            manager?.next()
//            toggleLabel(fastForwardLabel, enabled: event.keyPressed)
        }
    }
}

