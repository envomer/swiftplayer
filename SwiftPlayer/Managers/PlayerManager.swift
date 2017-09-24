//
//  PlayerManager.swift
//  SwiftPlayer
//
//  Created by Omer Mohamed Ali on 24/09/2017.
//  Copyright © 2017 Omer Mohamed Ali. All rights reserved.
//

import Cocoa
import AVFoundation
import RealmSwift

class PlayerManager: NSObject, AVAudioPlayerDelegate {
    static var sharedManager = PlayerManager()
    
    var isPlaying: Bool {
        return player?.isPlaying ?? false
    }
    var player: AVAudioPlayer?
    
    var currentIndex: Int?
    var currentSong: Song? = nil {
        didSet {
            if let currentSong = currentSong {
                currentIndex = currentPlaylist.index(of: currentSong)
                if currentSong.location  != player?.url?.path {
                    player = try? AVAudioPlayer(contentsOf:
                        NSURL(fileURLWithPath: currentSong.location) as URL
                    )
                    
                    player?.volume = volume
                }
            } else {
                stop()
                player = nil
            }
        }
    }
    
    // the current used playlist
    var currentPlaylist: [Song] = []
    // shuffled default playlist
    var shufflePlaylist: [Song] = []
    // Default playlist
    var playlist: [Song] = [] {
        didSet {
            if !isShuffle {
                currentPlaylist = playlist
            }
            
        }
    }
    
    var isRepeated = false {
        didSet {
            print("isRepeatd: \(isRepeated)")
        }
    }
    var isShuffle = false {
        didSet {
            print("isShuffle: \(isShuffle)")
            if isShuffle {
                if let currentSong = currentSong {
                    let list = playlist.filter { song -> Bool in
                        return song.location != currentSong.location
                    }
                    shufflePlaylist = [currentSong] + list.shuffle()
                } else {
                    shufflePlaylist = playlist.shuffle()
                }
                currentPlaylist = shufflePlaylist
            } else {
                currentPlaylist = playlist
            }
        }
    }
    var volume: Float = 0.5
    
    // MARK: - Lifecycle methods    
    override init() {
        super.init()
    }
    
    deinit {
        
    }
    
    // MARK: - Player controls
    
    func play() {
        if isPlaying {
            pause()
            return
        }
        
        if currentPlaylist.isEmpty {
            loadAllSongs()
        }
        
        if currentSong == nil {
            currentSong = currentPlaylist[0]
        }
        
        print("playing", currentSong?.title)
        
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
    
    func next() {
        guard var currentIndex = currentIndex else { return }
        currentIndex += 1
        
        if currentIndex > currentPlaylist.count - 1 {
            currentIndex = 0
        }
        
        currentSong = currentPlaylist[currentIndex]
        play()
    }
    
    func stop() {
        player?.stop()
    }
    
    func rewind() {
        guard var currentIndex = currentIndex else { return }
        currentIndex -= 1
        
        if currentIndex < 0 {
            currentIndex = currentPlaylist.count - 1
        }
        
        currentSong = currentPlaylist[currentIndex]
        play()
    }
    
    func shuffle() {
        
    }
    
    
    private func loadAllSongs() {
        let realm = try! Realm()
        playlist = realm.objects(Song.self).map { song in return song }
    }
}
