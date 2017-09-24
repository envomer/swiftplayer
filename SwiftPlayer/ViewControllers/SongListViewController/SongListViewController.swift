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
        
        tableView.dataSource = self
        
        // check if realm database has any new columns -> migrate
        RealmMigrationManager.migrate()
        
        // Migrate only on first launch.
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "APP_LAUNCHED") == false {
            let soManager = SongManager()
            try! _ = soManager.importSongs()
            defaults.set(true, forKey: "APP_LAUNCHED")
        }
        
        // get songs from realm database
        let realm = try! Realm()
        let result = realm.objects(Song.self)
        songs = result.map{song in
            return song
        }
        
        // observer notifications
        let nc = NotificationCenter.default
        nc.addObserver(
            self,
            selector: #selector(changeSong),
            name: Notification.Name(Constants.Notifications.ChangeSong),
            object: nil
        )
        nc.addObserver(
            self,
            selector: #selector(switchPlaylist),
            name: Notification.Name(Constants.Notifications.SwitchPlaylist),
            object: nil
        )
        
        // allow song deletions
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Delete", action: #selector(deleteSongs), keyEquivalent: "d"))
        tableView.menu = menu
//        tableView.allowsMultipleSelection = true // can also be done in storyboard
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
    
    func switchPlaylist(notification: Notification) {
        guard let playlist = notification.userInfo?[Constants.NotificationUserInfos.Playlist] as? Playlist else { return }
        
        songs = playlist.songs.map { song in return song }
        tableView.reloadData()
    }
    
    // Delete songs usong right mouse click
    func deleteSongs(sender: AnyObject) {
        let songsMutableArray = NSMutableArray(array: songs)
        let toBeDeletedSongs = songsMutableArray.objects(at: tableView.selectedRowIndexes) as? [Song]
        songsMutableArray.removeObjects(at: tableView.selectedRowIndexes)
        
        //????
        if let mutableArray = songsMutableArray as AnyObject as? [Song] {
            songs = mutableArray
            tableView.reloadData()
        }
        
        
        if let songs = toBeDeletedSongs {
            for song in songs {
                song.delete()
            }
        }
    }
}

extension SongListViewController: NSTableViewDataSource {
    func tableView(_ tableView: NSTableView, pasteboardWriterForRow row: Int) -> NSPasteboardWriting? {
        let song = songs[row]
        print("dropped song", song)
        
        let pbItem = NSPasteboardItem()
        pbItem.setString(song.location, forType: NSPasteboardTypeString)
        return pbItem
    }
}
