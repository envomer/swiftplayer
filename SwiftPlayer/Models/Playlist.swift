//
//  Playlist.swift
//  SwiftPlayer
//
//  Created by Omer Mohamed Ali on 24/09/2017.
//  Copyright © 2017 Omer Mohamed Ali. All rights reserved.
//

import Cocoa
import RealmSwift

class Playlist: Object {
    
    dynamic var name: String = "Playlist"
    let songs = List<Song>()
//    dynamic var dynamite: Bool
    
//    convenience required init() {
//        self.init()
//
//        self.name = "Playlist"
//    }
//
//    override static func ignoredProperties() -> [String] {
//        return ["dynamite"]
//    }
    
    func delete() {
//        if dynamite { return }
        if name == "All songs" { return }
        try! realm?.write {
            realm?.delete(self)
        }
    }
    
}
