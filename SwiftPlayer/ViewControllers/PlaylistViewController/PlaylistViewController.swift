//
//  PlaylistViewController.swift
//  SwiftPlayer
//
//  Created by Omer Mohamed Ali on 24/09/2017.
//  Copyright © 2017 Omer Mohamed Ali. All rights reserved.
//

import Cocoa
import RealmSwift

class PlaylistViewController: NSViewController {
    var playlists = [Playlist]() {
        didSet {
            outlineView.reloadData()
            outlineView.expandItem(nil, expandChildren: true)
        }
    }
    
    @IBOutlet weak var outlineView: NSOutlineView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        outlineView.dataSource = self
        outlineView.delegate = self
        outlineView.backgroundColor = NSColor.clear
        
        RealmMigrationManager.migrate()
        
        let realm = try! Realm()
        playlists = realm.objects(Playlist.self).map {playlist in
            return playlist
        }
        
        let songsAll = realm.objects(Song.self).map{song in
            return song
        }
        
        let playlistAllSongs = Playlist()
//        playlistAllSongs.dynamite = true
        playlistAllSongs.name = "All songs"
        playlistAllSongs.songs.append(objectsIn: songsAll)
        playlists.insert(playlistAllSongs, at: 0)
        
        outlineView.register(forDraggedTypes: [NSPasteboardTypeString])
        
        // menu to delete playlists
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Delete", action: #selector(deletePlaylist), keyEquivalent: "d"))
        outlineView.menu = menu
    }
    
    // MARK: - Actions
    
    @IBAction func addPlaylist(_ sender: NSButtonCell) {
        let playlist = Playlist()
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(playlist)
        }
        
        playlists.append(playlist)
    }
    
    // MARK: - Helpers
    
    func isHeader(item: Any) -> Bool {
        return item is String
    }
    
    // delete playlist
    func deletePlaylist(sender: AnyObject) {
        print(outlineView.clickedRow)
        
        let playlist = playlists[outlineView.clickedRow - 1]
        playlists.remove(at: outlineView.clickedRow - 1)
        outlineView.reloadData()
        playlist.delete()
        
    }
}

extension PlaylistViewController: NSOutlineViewDataSource {
    // ??
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if item == nil {
            return 1
        }
        
        return playlists.count
    }
    
    //??
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        return isHeader(item: item)
    }
    
    //??
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if item == nil {
            //            return ["All", "Library"]
            return "Library"
        }
        
        return playlists[index]
    }
    
    //??
    func outlineView(_ outlineView: NSOutlineView, objectValueFor tableColumn: NSTableColumn?, byItem item: Any?) -> Any? {
        return item
    }
    
    // Drag behaviour
    func outlineView(_ outlineView: NSOutlineView, validateDrop info: NSDraggingInfo, proposedItem item: Any?, proposedChildIndex index: Int) -> NSDragOperation {
        
        let canDrag = item is Playlist && index < 0
        if canDrag {
            return .move
        }
        
        return []
    }
    
    // Drop behaviour
    func outlineView(_ outlineView: NSOutlineView, acceptDrop info: NSDraggingInfo, item: Any?, childIndex index: Int) -> Bool {
        guard let playlist = item as? Playlist else { return false }
        
        let pb = info.draggingPasteboard()
        let location = pb.string(forType: NSPasteboardTypeString)
        
        let realm = try! Realm()
        if let location = location?.replacingOccurrences(of: "'", with: "\\'") {
            if let song = realm.objects(Song.self).filter("location = '\(location)'").first {
                let index = playlist.songs.index(of: song)
                if index == nil {
                    try! realm.write {
                        playlist.songs.append(song)
                        outlineView.reloadData()
                    }
                }
                
            }
            return true
        }
        return false
    }
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        if isHeader(item: item) {
            return outlineView.make(withIdentifier: "HeaderCell", owner: self)
        }
        
        let view = outlineView.make(withIdentifier: "DataCell", owner: self) as? CustomTableCellView
        if let playlist = item as? Playlist {
            view?.textField?.stringValue = "\(playlist.name)"
            view?.textField?.delegate = self
            view?.songCount.stringValue = "\((playlist.songs.count))"
        }
        
        return view
    }
}

extension PlaylistViewController: NSOutlineViewDelegate {
    
    func outlineView(_ outlineView: NSOutlineView, shouldSelectItem item: Any) -> Bool {
        return !isHeader(item: item)
    }
    
    func outlineView(_ outlineView: NSOutlineView, shouldShowOutlineCellForItem item: Any) -> Bool {
        return false
    }
    
    func outlineViewSelectionDidChange(_ notification: Notification) {
        let playlist = playlists[outlineView.selectedRow - 1]
        
        let nc = NotificationCenter.default
        
        nc.post(
            name: Notification.Name(Constants.Notifications.SwitchPlaylist),
            object: self,
            userInfo: [
                Constants.NotificationUserInfos.Playlist: playlist
            ]
        )
    }
}

extension PlaylistViewController: NSTextFieldDelegate {
    
    override func controlTextDidEndEditing(_ obj: Notification) {
        if let textField = obj.object as? NSTextField {
            print(textField.stringValue)
            let row = outlineView.row(for: textField)
            let playlist = playlists[row - 1]
            
            let realm = try! Realm()
            try! realm.write {
                playlist.name = textField.stringValue
            }
        }
    }
    
}

