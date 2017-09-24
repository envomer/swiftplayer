//
//  Song.swift
//  SwiftPlayer
//
//  Created by Omer Mohamed Ali on 24/09/2017.
//  Copyright © 2017 Omer Mohamed Ali. All rights reserved.
//

import Cocoa
import RealmSwift
import iTunesLibrary

class Song: Object {
    
    dynamic var title: String = ""
    dynamic var location: String = ""
    dynamic var length: Double = 0
    
    convenience init(item: ITLibMediaItem) {
        self.init()
        
        self.title = item.title
        self.location = item.location?.path ?? ""
        self.length = TimeInterval(item.totalTime) / 1000.0
    }
    
}
