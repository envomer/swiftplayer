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
    
}
