//
//  SongListViewController.swift
//  SwiftPlayer
//
//  Created by Omer Mohamed Ali on 24/09/2017.
//  Copyright © 2017 Omer Mohamed Ali. All rights reserved.
//

import Cocoa
import RealmSwift

class SongListViewController: NSViewController {
    @IBOutlet weak var tableView: NSTableView!
    
    dynamic var songs: [Song] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        RealmMigrationManager.migrate()
        
        // Migrate only on first launch.
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "APP_LAUNCHED") == false {
            let soManager = SongManager()
            try! soManager.importSongs()
            defaults.set(true, forKey: "APP_LAUNCHED")
        }
        
        let realm = try! Realm()
        let result = realm.objects(Song.self)
        
        songs = result.map{song in
            return song
        }
    }
    
    @IBAction func doubleClick(_ sender: NSTableView) {
        print(tableView.selectedRow)
        
        if tableView.selectedRow > -1 {
            let manager = PlayerManager.sharedManager
            manager.currentPlaylist = songs
            manager.currentSong = songs[tableView.selectedRow]
            manager.isShuffle = manager.isShuffle ? true : false
            manager.stop()
            manager.play()
        }
    }
    
}
