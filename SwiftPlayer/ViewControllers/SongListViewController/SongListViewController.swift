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
        
        let nc = NotificationCenter.default
        
        nc.addObserver(
            self,
            selector: #selector(changeSong),
            name: Notification.Name(Constants.Notifications.ChangeSong),
            object: nil
        )
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
    
    // MARK: - Notification
    func changeSong(notification: Notification) {
        guard let song = notification.userInfo?[Constants.NotificationUserInfos.Song] as? Song else { return }
        
        let index = songs.index(of: song)
        
        if let index = index {
            let set = IndexSet(integer: index)
            tableView.selectRowIndexes(set, byExtendingSelection: false)
            tableView.scrollRowToVisible(index)
        }
    }
    
}
