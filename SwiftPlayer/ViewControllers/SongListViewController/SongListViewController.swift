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
    
    dynamic var songs: [Song] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        let realm = try! Realm()
        let result = realm.objects(Song.self)
        
        songs = result.map{song in
            return song
        }
    }
    
}
