//
//  PlayerManager.swift
//  SwiftPlayer
//
//  Created by Omer Mohamed Ali on 24/09/2017.
//  Copyright © 2017 Omer Mohamed Ali. All rights reserved.
//

import Cocoa
import AVFoundation

class PlayerManager: NSObject, AVAudioPlayerDelegate {
    static var sharedManager = PlayerManager()
    
    var isPlaying: Bool = false
    var player: AVAudioPlayer?
    
    // MARK: - Player controls
    
    func play() {
        if isPlaying {
            pause()
        }
    }
    
    func pause() {
        
    }
    
    func next() {
        
    }
    
    func rewind() {
        
    }
    
    func shuffle() {
        
    }
    
    func repeatPlaylist() {
        
    }
}
